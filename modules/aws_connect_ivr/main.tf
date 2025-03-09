resource "aws_connect_queue" "sales_queue" {
  instance_id = var.aws_connect_instance_id
  name        = "Sales Queue"
  description = "Handles Sales calls"
}

resource "aws_connect_queue" "support_queue" {
  instance_id = var.aws_connect_instance_id
  name        = "Support Queue"
  description = "Handles Support calls"
}

resource "aws_connect_queue" "billing_queue" {
  instance_id = var.aws_connect_instance_id
  name        = "Billing Queue"
  description = "Handles Billing calls"
}

resource "aws_connect_contact_flow" "ivr_flow" {
  instance_id = var.aws_connect_instance_id
  name        = "IVR Main Menu"
  description = "Main IVR with 3 options"
  content     = file("${path.module}/ivr_flow.json")
  type        = "CONTACT_FLOW"
}
