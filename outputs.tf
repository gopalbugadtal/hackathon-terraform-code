# EC2 Outputs
output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = module.ec2.instance_id
}

output "ec2_instance_public_ip" {
  description = "EC2 Instance Public IP"
  value       = module.ec2.instance_public_ip
}

output "ec2_instance_private_ip" {
  description = "EC2 Instance Private IP"
  value       = module.ec2.instance_private_ip
}

output "ec2_ami_id" {
  description = "AMI ID Used for EC2"
  value       = module.ec2.ami_id
}

# Security Group Outputs
output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}

output "security_group_name" {
  description = "Security Group Name"
  value       = module.security_group.security_group_name
}

output "rds_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds.id
}

# RDS Outputs
output "rds_instance_id" {
  description = "RDS Instance ID"
  value       = module.rds.db_instance_id
}

output "rds_instance_endpoint" {
  description = "RDS Instance Endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_instance_port" {
  description = "RDS Instance Port"
  value       = module.rds.db_instance_port
}

output "rds_database_name" {
  description = "RDS Database Name"
  value       = var.rds_database_name
}

# ECR Outputs
output "ecr_repository_urls" {
  description = "ECR Repository URLs"
  value       = module.ecr.repository_urls
}

output "ecr_repository_arns" {
  description = "ECR Repository ARNs"
  value       = module.ecr.repository_arns
}

output "ecr_registry_id" {
  description = "ECR Registry ID"
  value       = module.ecr.registry_id
}

# ALB Outputs
output "alb_id" {
  description = "ALB ID"
  value       = module.alb.load_balancer_id
}

output "alb_arn" {
  description = "ALB ARN"
  value       = module.alb.load_balancer_arn
}

output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = module.alb.load_balancer_dns_name
}

output "alb_zone_id" {
  description = "ALB Zone ID"
  value       = module.alb.load_balancer_zone_id
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = module.alb.target_group_arn
}

output "target_group_id" {
  description = "Target Group ID"
  value       = module.alb.target_group_id
}

# VPC Outputs
output "default_vpc_id" {
  description = "Default VPC ID"
  value       = data.aws_vpc.default.id
}

# Summary
output "infrastructure_summary" {
  description = "Infrastructure Summary"
  value = {
    region       = var.aws_region
    ec2_instance = module.ec2.instance_id
    rds_database = module.rds.db_instance_id
    alb_endpoint = module.alb.load_balancer_dns_name
    ecr_repos    = module.ecr.repository_urls
  }
}
