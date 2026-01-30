output "repository_urls" {
  description = "ECR Repository URLs"
  value       = [for repo in aws_ecr_repository.main : repo.repository_url]
}

output "repository_arns" {
  description = "ECR Repository ARNs"
  value       = [for repo in aws_ecr_repository.main : repo.arn]
}

output "registry_id" {
  description = "ECR Registry ID"
  value       = aws_ecr_repository.main[0].registry_id
}
