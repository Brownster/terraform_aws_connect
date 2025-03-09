resource "aws_s3_bucket" "call_recordings" {
  bucket        = "aws-connect-call-recordings-${var.customer_id}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "recording_encryption" {
  bucket = aws_s3_bucket.call_recordings.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = var.kms_key_arn
    }
  }
}


resource "aws_s3_bucket_public_access_block" "recording_access" {
  bucket = aws_s3_bucket.call_recordings.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "recording_retention" {
  bucket = aws_s3_bucket.call_recordings.id

  rule {
    id = "auto-delete-after-30-days"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}

resource "aws_iam_role" "connect_recording_role" {
  name = "AWSConnectCallRecordingRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "connect.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "connect_recording_policy" {
  name = "AWSConnectCallRecordingPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ],
        Resource = "${aws_s3_bucket.call_recordings.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "connect_recording_policy_attach" {
  role       = aws_iam_role.connect_recording_role.name
  policy_arn = aws_iam_policy.connect_recording_policy.arn
}

resource "aws_connect_contact_flow" "call_recording_flow" {
  instance_id = var.aws_connect_instance_id
  name        = "Enable Call Recording"
  description = "Records all inbound and outbound calls"
  content     = file("${path.module}/call_recording_flow.json")
  type        = "CONTACT_FLOW"
}
