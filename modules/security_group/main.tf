resource "aws_security_group" "main" {
  name        = var.sg_name
  description = "Security Group for Artificial Instinct"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Artificial-Instinct"
  }
}

# Ingress Rules
resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_ports)

  type              = "ingress"
  from_port         = var.ingress_ports[count.index]
  to_port           = var.ingress_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = [var.ingress_cidr]
  security_group_id = aws_security_group.main.id
}

# Egress Rule - Allow all outbound traffic
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}
