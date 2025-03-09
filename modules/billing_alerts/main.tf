resource "aws_sns_topic" "billing_alerts" {
  name = "BillingAlerts-${var.customer_id}"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "BillingAlarm-${var.customer_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace          = "AWS/Billing"
  period             = "86400" # Daily checks
  statistic          = "Maximum"
  threshold         = var.billing_threshold
  actions_enabled   = true
  alarm_actions     = [aws_sns_topic.billing_alerts.arn]

  dimensions = {
    Currency = "USD"
  }
}
