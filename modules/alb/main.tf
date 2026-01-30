# Data source to get default VPC subnets
data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = [true]
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_group_ids
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection     = var.enable_deletion_protection
  enable_http2                   = var.enable_http2
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  tags = {
    Name = "Artificial-Instinct"
  }
}

# Target Group
resource "aws_lb_target_group" "main" {
  name     = "artificial-instinct-tg"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  tags = {
    Name = "Artificial-Instinct"
  }
}

# Register Target with Target Group
resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = var.instance_id
  port             = var.target_port
}

# HTTP Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

# Data source to get default VPC
data "aws_vpc" "default" {
  default = true
}
