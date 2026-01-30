resource "aws_ecr_repository" "main" {
  count = length(var.repository_names)

  name                 = var.repository_names[count.index]
  image_tag_mutability = var.image_tag_mutability
  #scan_on_push         = var.scan_on_push
  force_delete         = true

  tags = {
    Name = "Artificial-Instinct"
  }
}

resource "aws_ecr_lifecycle_policy" "main" {
  count = length(var.repository_names)

  repository = aws_ecr_repository.main[count.index].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than ${var.image_expiration_days} days"
        selection = {
          tagStatus     = "any"
          countType     = "sinceImagePushed"
          countUnit     = "days"
          countNumber   = var.image_expiration_days
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
