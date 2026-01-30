variable "allocated_storage" {
  description = "Allocated Storage in GB"
  type        = number
  default     = 10
}

variable "engine" {
  description = "Database Engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database Engine Version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDS Instance Class"
  type        = string
  default     = "db.t4g.small"
}

variable "db_name" {
  description = "Database Name"
  type        = string
  default     = "artificial-instinct-db"
}

variable "username" {
  description = "Master Username"
  type        = string
  sensitive   = true
  default     = "admin"
}

variable "password" {
  description = "Master Password"
  type        = string
  sensitive   = true
  default     = "root"
}

variable "multi_az" {
  description = "Enable Multi-AZ"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "Storage Type"
  type        = string
  default     = "gp2"
}

variable "skip_final_snapshot" {
  description = "Skip Final Snapshot"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Publicly Accessible"
  type        = bool
  default     = false
}

variable "db_identifier" {
  description = "DB Instance Identifier"
  type        = string
  default     = "artificial-instinct-db"
}

variable "security_group_ids" {
  description = "VPC Security Group IDs"
  type        = list(string)
}
