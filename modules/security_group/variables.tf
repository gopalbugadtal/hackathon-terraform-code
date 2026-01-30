variable "vpc_id" {
  description = "VPC ID (Default VPC)"
  type        = string
}

variable "sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "artificial-instinct-sg"
}

variable "ingress_ports" {
  description = "Ingress Ports"
  type        = list(number)
  default     = [22, 80, 443, 3000, 8247]
}

variable "ingress_cidr" {
  description = "Ingress CIDR Block"
  type        = string
  default     = "0.0.0.0/0"
}
