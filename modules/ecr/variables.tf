variable "repository_names" {
  description = "ECR Repository Names"
  type        = list(string)
  default     = ["backend/nexus-agent", "frontend/co-agent"]
}

variable "image_tag_mutability" {
  description = "Image Tag Mutability"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Scan on Push"
  type        = bool
  default     = false
}

variable "image_expiration_days" {
  description = "Image Expiration Days"
  type        = number
  default     = 30
}
