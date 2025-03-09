resource "aws_connect_instance" "contact_center" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = var.enable_inbound_calls
  outbound_calls_enabled   = var.enable_outbound_calls
  auto_resolve_best_voices = true
}

resource "aws_connect_contact_flow" "default" {
  instance_id = aws_connect_instance.contact_center.id
  name        = "WelcomeFlow"
  description = "Default contact flow"
  content     = file("${path.module}/contact_flow.json")
  type        = "CONTACT_FLOW"
}

resource "aws_connect_phone_number" "phone" {
  target_arn = aws_connect_instance.contact_center.arn
  country_code = "US"
  type         = "TOLL_FREE"
}
