variable "function_name" {
  type        = string
  description = "Lambda function name"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for Lambda execution"
}

variable "source_dir" {
  type        = string
  description = "Path to Lambda source code directory"
}

variable "handler" {
  type        = string
  description = "Lambda handler"
  default     = "index.handler"
}

variable "runtime" {
  type        = string
  description = "Lambda runtime"
  default     = "nodejs20.x"
}

variable "timeout" {
  type        = number
  description = "Function timeout in seconds"
  default     = 10
}

variable "memory_size" {
  type        = number
  description = "Function memory in MB"
  default     = 128
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for environment variable"
  default     = ""
}

variable "environment_variables" {
  type        = map(string)
  description = "Additional environment variables"
  default     = {}
}

variable "api_gateway_execution_arn" {
  type        = string
  description = "API Gateway execution ARN for permission"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment identifier"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
