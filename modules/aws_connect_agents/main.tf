resource "aws_connect_user_hierarchy_group" "sales_group" {
  instance_id = var.aws_connect_instance_id
  name        = "Sales"
}

resource "aws_connect_user_hierarchy_group" "support_group" {
  instance_id = var.aws_connect_instance_id
  name        = "Support"
}

resource "aws_connect_user" "agents" {
  for_each         = { for agent in var.agents : agent.username => agent }
  instance_id      = var.aws_connect_instance_id
  username         = each.value.username
  hierarchy_group_id = each.value.role == "Sales" ? aws_connect_user_hierarchy_group.sales_group.id : aws_connect_user_hierarchy_group.support_group.id
  security_profile_ids = [aws_connect_security_profile.default.id]
  identity_info {
    email = each.value.email
  }
  phone_config {
    phone_type = "SOFT_PHONE"
  }
}

resource "aws_connect_instance" "contact_center" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  outbound_calls_enabled   = true
}

resource "aws_connect_phone_number" "ddi" {
  target_arn  = aws_connect_instance.contact_center.arn
  country_code = "US"
  type         = "DID"
  phone_number = "+1555000001"
}

resource "aws_connect_user_hierarchy_group" "sales_group" {
  instance_id = var.aws_connect_instance_id
  name        = "Sales"
}

resource "aws_connect_user_hierarchy_group" "support_group" {
  instance_id = var.aws_connect_instance_id
  name        = "Support"
}

resource "aws_connect_user_hierarchy_group" "billing_group" {
  instance_id = var.aws_connect_instance_id
  name        = "Billing"
}

resource "aws_connect_user" "agents" {
  for_each    = { for agent in var.agents : agent.username => agent }
  instance_id = var.aws_connect_instance_id
  username    = each.value.username
  hierarchy_group_id = (
    each.value.role == "Sales" ? aws_connect_user_hierarchy_group.sales_group.id :
    each.value.role == "Support" ? aws_connect_user_hierarchy_group.support_group.id :
    aws_connect_user_hierarchy_group.billing_group.id
  )
  security_profile_ids = [aws_connect_security_profile.default.id]
  identity_info {
    email = each.value.email
  }
  phone_config {
    phone_type = "SOFT_PHONE"
  }
}
