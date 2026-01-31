variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t4g.medium"
}

variable "ec2_key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "artificial-instinct-key"
}

variable "ec2_root_volume_size" {
  description = "EC2 Root Volume Size in GB"
  type        = number
  default     = 20
}

variable "ec2_root_volume_type" {
  description = "EC2 Root Volume Type"
  type        = string
  default     = "gp3"
}

variable "ecr_backend_repo_name" {
  description = "ECR Backend Repository Name"
  type        = string
  default     = "backend/nexus-agent"
}

variable "ecr_frontend_repo_name" {
  description = "ECR Frontend Repository Name"
  type        = string
  default     = "frontend/co-agent"
}

variable "alb_name" {
  description = "ALB Name"
  type        = string
  default     = "artificial-instinct-alb"
}

variable "alb_enable_deletion_protection" {
  description = "ALB Enable Deletion Protection"
  type        = bool
  default     = false
}

variable "sg_ingress_ports" {
  description = "Security Group Ingress Ports"
  type        = list(number)
  default     = [22, 80, 443, 3000, 8247]
}

variable "sg_ingress_cidr" {
  description = "Security Group Ingress CIDR"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ec2_user_data" {
  description = "User data script for EC2 instance"
  type        = string
  default     = ""
}
