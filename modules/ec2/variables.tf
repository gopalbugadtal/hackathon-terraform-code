variable "ami_id" {
  description = "AMI ID for Amazon Linux 2"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t4g.medium"
}

variable "key_name" {
  description = "Key Pair Name"
  type        = string
  default     = "artificial-instinct-key"
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Associate Public IP Address"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Root Volume Size in GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Root Volume Type"
  type        = string
  default     = "gp3"
}

variable "instance_name" {
  description = "EC2 Instance Name"
  type        = string
  default     = "artificial-instinct-ec2"
}

variable "user_data" {
  description = "User data script for EC2 instance"
  type        = string
  default     = ""
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name for EC2"
  type        = string
  default     = ""
}
