output "load_balancer_id" {
  description = "ALB ID"
  value       = aws_lb.main.id
}

output "load_balancer_arn" {
  description = "ALB ARN"
  value       = aws_lb.main.arn
}

output "load_balancer_dns_name" {
  description = "ALB DNS Name"
  value       = aws_lb.main.dns_name
}

output "load_balancer_zone_id" {
  description = "ALB Zone ID"
  value       = aws_lb.main.zone_id
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.main.arn
}

output "target_group_id" {
  description = "Target Group ID"
  value       = aws_lb_target_group.main.id
}
