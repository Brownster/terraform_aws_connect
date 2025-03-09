variable "customer_id" {
  description = "Unique customer identifier"
  type        = string
}

variable "alert_email" {
  description = "Email to send billing alerts"
  type        = string
}

variable "billing_threshold" {
  description = "Dollar amount to trigger alert"
  type        = number
  default     = 100
}
