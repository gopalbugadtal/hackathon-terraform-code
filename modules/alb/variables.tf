variable "alb_name" {
  description = "ALB Name"
  type        = string
  default     = "artificial-instinct-alb"
}

variable "load_balancer_type" {
  description = "Load Balancer Type"
  type        = string
  default     = "application"
}

variable "internal" {
  description = "Internal Load Balancer"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

variable "subnets" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Enable Deletion Protection"
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Enable HTTP/2"
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable Cross Zone Load Balancing"
  type        = bool
  default     = true
}

variable "instance_id" {
  description = "EC2 Instance ID for Target Group"
  type        = string
}

variable "target_port" {
  description = "Target Port"
  type        = number
  default     = 80
}
