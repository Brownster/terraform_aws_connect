output "sns_topic_arn" {
  description = "SNS topic for billing alerts"
  value       = aws_sns_topic.billing_alerts.arn
}
