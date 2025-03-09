aws_region = "us-east-1"
s3_bucket_name = "my-terraform-s3-bucket-12345"
enable_rds = true

agents = [
  {
    username = "john_doe"
    email    = "john@example.com"
    role     = "Sales"
    ddi      = "+123456789"
  },
  {
    username = "jane_smith"
    email    = "jane@example.com"
    role     = "Support"
    ddi      = "+987654321"
  }
]
