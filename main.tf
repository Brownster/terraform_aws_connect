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

module "aws_connect_agents" {
  source                  = "./modules/aws_connect_agents"
  aws_connect_instance_id = module.aws_connect.instance_id
  agents                  = var.agents
}

module "aws_connect_ivr" {
  source                  = "./modules/aws_connect_ivr"
  aws_connect_instance_id = module.aws_connect.instance_id
}

module "aws_kms" {
  source = "./modules/aws_kms"
}

module "aws_connect_recording" {
  source                  = "./modules/aws_connect_recording"
  aws_connect_instance_id = module.aws_connect.instance_id
  customer_id             = "mycustomer"
  kms_key_arn             = module.aws_kms.kms_key_arn
}
