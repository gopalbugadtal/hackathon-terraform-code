output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "EC2 Instance Private IP"
  value       = aws_instance.main.private_ip
}

output "ami_id" {
  description = "AMI ID used"
  value       = var.ami_id
}
