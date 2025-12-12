variable "name" {
  type        = string
  description = "API Gateway name"
}

variable "cognito_user_pool_arn" {
  type        = string
  description = "Cognito User Pool ARN for authorizer"
}

variable "lambda_invoke_arn" {
  type        = string
  description = "Lambda invoke ARN for integration"
}

variable "lambda_function_name" {
  type        = string
  description = "Lambda function name"
}

variable "stage_name" {
  type        = string
  description = "Deployment stage name"
  default     = "dev"
}

variable "endpoint_type" {
  type        = string
  description = "API endpoint type"
  default     = "REGIONAL"
}

variable "resource_path" {
  type        = string
  description = "API resource path"
  default     = "ride"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
