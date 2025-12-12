variable "name" {
  type        = string
  description = "IAM role name"
}

variable "trusted_services" {
  type        = list(string)
  description = "AWS services allowed to assume this role"
  default     = ["lambda.amazonaws.com"]
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "List of managed policy ARNs to attach"
  default     = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

variable "dynamodb_table_arn" {
  type        = string
  description = "DynamoDB table ARN for inline write policy"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
