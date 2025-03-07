resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "rds-db-credentials"
  description = "Database credentials for Terraform-managed RDS"

  tags = {
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
