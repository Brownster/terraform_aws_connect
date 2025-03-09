module "aws_connect" {
  source = "./modules/aws_connect"

  enable_inbound_calls  = true
  enable_outbound_calls = true
}

module "billing_alerts" {
  source            = "./modules/billing_alerts"
  customer_id       = "acme-corp"
  alert_email       = "alerts@acme.com"
  billing_threshold = 200  # Custom threshold for this customer
}
