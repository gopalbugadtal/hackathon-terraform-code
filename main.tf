# Data source to get default VPC
data "aws_vpc" "default" {
  default = true
}

# Local variables
locals {
  ec2_user_data = file("${path.module}/userdata.sh")
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
  user_data                   = local.ec2_user_data
  iam_instance_profile_name   = module.iam.instance_profile_name

  depends_on = [module.iam]
}

# ECR Module
module "ecr" {
  source = "./modules/ecr"

  repository_names       = [var.ecr_backend_repo_name, var.ecr_frontend_repo_name]
  image_tag_mutability   = "MUTABLE"
  scan_on_push           = false
  image_expiration_days  = 30
}

# IAM Module (commented - requires AWS admin permissions)
module "iam" {
  source = "./modules/iam"

  role_name              = "artificial-instinct-ec2-role"
  policy_name            = "artificial-instinct-ec2-ecr-policy"
  instance_profile_name  = "artificial-instinct-ec2-profile"
  ecr_repository_arns    = module.ecr.repository_arns
}

#ALB Module
# module "alb" {
#   source = "./modules/alb"
#   alb_name               = var.alb_name
#   load_balancer_type     = "application"
#   internal               = false
#   security_group_ids     = [module.security_group.security_group_id]
#   subnets                = [] # Handled by module with data source
#   enable_deletion_protection = var.alb_enable_deletion_protection
#   enable_http2           = true
#   enable_cross_zone_load_balancing = true
#   instance_id            = module.ec2.instance_id
#   target_port            = 80
# }
