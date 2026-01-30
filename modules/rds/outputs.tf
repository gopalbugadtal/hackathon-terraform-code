output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.main.id
}

output "db_instance_endpoint" {
  description = "RDS Instance Endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_port" {
  description = "RDS Instance Port"
  value       = aws_db_instance.main.port
}

output "db_instance_resource_id" {
  description = "RDS Instance Resource ID"
  value       = aws_db_instance.main.resource_id
}
