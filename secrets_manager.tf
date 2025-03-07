resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "rds-db-credentials"
  description = "Database credentials for Terraform-managed RDS"

  tags = {https://github.com/Brownster/terraform_aws_connect/edit/main/secrets_manager.tf
    Environment = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "admin"
    password = "SuperSecureP@ssword!"
  })
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)
}

resource "aws_db_instance" "default" {
  count             = var.enable_rds ? 1 : 0
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20
  db_name          = "mydb"
  username        = local.db_creds["username"]
  password        = local.db_creds["password"]
  skip_final_snapshot = true
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

