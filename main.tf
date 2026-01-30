# Data source to get default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group Module
module "security_group" {
  source = "./modules/security_group"

  vpc_id           = data.aws_vpc.default.id
  sg_name          = "artificial-instinct-sg"
  ingress_ports    = var.sg_ingress_ports
  ingress_cidr     = var.sg_ingress_cidr
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"

  ami_id                      = "ami-0f0613925dab57b30"
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_key_name
  security_group_ids          = [module.security_group.security_group_id]
  associate_public_ip_address = true
  root_volume_size            = var.ec2_root_volume_size
  root_volume_type            = var.ec2_root_volume_type
  instance_name               = "artificial-instinct-ec2"
}

# RDS Security Group (separate from EC2 SG)
resource "aws_security_group" "rds" {
  name        = "artificial-instinct-rds-sg"
  description = "Security Group for RDS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.security_group.security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Artificial-Instinct"
  }
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  allocated_storage = var.rds_allocated_storage
  engine            = var.rds_engine
  engine_version    = "8.0"
  instance_class    = var.rds_instance_type
  db_name           = var.rds_database_name
  username          = var.rds_master_username
  password          = var.rds_master_password
  multi_az          = var.rds_multi_az
  skip_final_snapshot = var.rds_skip_final_snapshot
  storage_type      = "gp2"
  publicly_accessible = false
  db_identifier     = "artificial-instinct-db"
  security_group_ids = [aws_security_group.rds.id]
}

# ECR Module
module "ecr" {
  source = "./modules/ecr"

  repository_names       = [var.ecr_backend_repo_name, var.ecr_frontend_repo_name]
  image_tag_mutability   = "MUTABLE"
  scan_on_push           = false
  image_expiration_days  = 30
}

#ALB Module
module "alb" {
  source = "./modules/alb"
  alb_name               = var.alb_name
  load_balancer_type     = "application"
  internal               = false
  security_group_ids     = [module.security_group.security_group_id]
  subnets                = [] # Handled by module with data source
  enable_deletion_protection = var.alb_enable_deletion_protection
  enable_http2           = true
  enable_cross_zone_load_balancing = true
  instance_id            = module.ec2.instance_id
  target_port            = 80
}
