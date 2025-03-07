resource "aws_s3_bucket" "terraform_state" {
  bucket = var.backend_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  # Enable default AWS-managed KMS encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.logging_bucket.id
    target_prefix = "logs/"
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}

# S3 Bucket for Logging
resource "aws_s3_bucket" "logging_bucket" {
  bucket = "${var.backend_bucket_name}-logs"
  acl    = "log-delivery-write"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Locking"
  }
}
