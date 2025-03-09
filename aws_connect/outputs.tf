output "connect_instance_id" {
  value = aws_connect_instance.contact_center.id
}

output "connect_phone_number" {
  value = aws_connect_phone_number.phone.phone_number
}
