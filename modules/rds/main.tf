resource "aws_db_instance" "main" {
  identifier     = var.db_identifier
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  storage_encrypted    = true
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql8.0"

  publicly_accessible = var.publicly_accessible
  multi_az            = var.multi_az

  vpc_security_group_ids = var.security_group_ids

  skip_final_snapshot       = var.skip_final_snapshot
  backup_retention_period   = 7
  enabled_cloudwatch_logs_exports = []

  tags = {
    Name = "Artificial-Instinct"
  }
}
