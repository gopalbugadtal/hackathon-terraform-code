output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.ec2_ecr_role.arn
}

output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.ec2_ecr_policy.arn
}
