output "agent_user_ids" {
  description = "List of AWS Connect agent user IDs"
  value       = { for agent in aws_connect_user.agents : agent.username => agent.id }
}

output "instance_id" {
  value = aws_connect_instance.contact_center.id
}

output "ddi_number" {
  value = aws_connect_phone_number.ddi.phone_number
}
