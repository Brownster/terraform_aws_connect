variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "Subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "enable_rds" {
  description = "Enable RDS"
  type        = bool
  default     = true
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type        = string
  default     = "my-terraform-bucket-unique-name"
}

variable "backend_bucket_name" {
  description = "S3 bucket for storing Terraform state"
  type        = string
  default     = "my-terraform-state-bucket-12345"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for state locking"
  type        = string
  default     = "terraform-lock-table"
}

variable "backend_bucket_name" {
  description = "S3 bucket for storing Terraform state"
  type        = string
  default     = "my-terraform-state-bucket-12345"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for state locking"
  type        = string
  default     = "terraform-lock-table"
}

variable "enable_rds" {
  description = "Enable RDS database instance"
  type        = bool
  default     = true
}
