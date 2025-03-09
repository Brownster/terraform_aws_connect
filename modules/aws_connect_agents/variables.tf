variable "aws_connect_instance_id" {
  description = "AWS Connect Instance ID"
  type        = string
}


variable "agents" {
  description = "List of agents"
  type        = list(object({
    username = string
    email    = string
    role     = string
  }))
}
