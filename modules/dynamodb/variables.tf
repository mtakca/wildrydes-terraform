variable "table_name" {
  type        = string
  description = "DynamoDB table name"
}

variable "environment" {
  type        = string
  description = "Environment identifier"
}

variable "hash_key" {
  type        = string
  description = "Partition key attribute name"
  default     = "RideId"
}

variable "billing_mode" {
  type        = string
  description = "Billing mode (PAY_PER_REQUEST or PROVISIONED)"
  default     = "PAY_PER_REQUEST"
}

variable "enable_point_in_time_recovery" {
  type        = bool
  description = "Enable point-in-time recovery"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "Enable deletion protection"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
