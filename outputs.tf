output "ec2_public_ip" {
  description = "Public IP of EC2 Instance"
  value       = aws_instance.web.public_ip
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.bucket.bucket
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = var.enable_rds ? aws_db_instance.default[0].endpoint : "RDS Disabled"
}

output "alb_dns" {
  description = "ALB DNS Name"
  value       = aws_lb.web_lb.dns_name
}
