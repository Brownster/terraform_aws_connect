resource "aws_kms_key" "call_recording_key" {
  description             = "KMS key for AWS Connect call recordings"
  enable_key_rotation     = true
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "call_recording_alias" {
  name          = "alias/aws-connect-call-recordings"
  target_key_id = aws_kms_key.call_recording_key.id
}
