variable "role_name" {
  description = "Name of the IAM role for EC2"
  type        = string
  default     = "artificial-instinct-ec2-role"
}

variable "policy_name" {
  description = "Name of the IAM policy for ECR access"
  type        = string
  default     = "artificial-instinct-ec2-ecr-policy"
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
  default     = "artificial-instinct-ec2-profile"
}

variable "ecr_repository_arns" {
  description = "ARNs of ECR repositories"
  type        = list(string)
}
