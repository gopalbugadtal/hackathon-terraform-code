# AWS Region
aws_region = "ap-south-1"

# EC2 Configuration
ec2_instance_type         = "t4g.medium"
ec2_key_name              = "artificial-instinct-key"
ec2_root_volume_size      = 20
ec2_root_volume_type      = "gp3"

# ECR Configuration
ecr_backend_repo_name     = "backend/nexus-agent"
ecr_frontend_repo_name    = "frontend/co-agent"

# ALB Configuration
alb_name                  = "artificial-instinct-alb"
alb_enable_deletion_protection = false

# Security Group Configuration
sg_ingress_ports          = [22, 80, 443, 3000]
sg_ingress_cidr           = "0.0.0.0/0"
