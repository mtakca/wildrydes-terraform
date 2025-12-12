output "api_invoke_url" {
  value       = module.api_gateway.invoke_url
  description = "API Gateway invoke URL for frontend config"
}

output "cognito_user_pool_id" {
  value       = module.cognito.user_pool_id
  description = "Cognito User Pool ID for frontend config"
}

output "cognito_client_id" {
  value       = module.cognito.client_id
  description = "Cognito App Client ID for frontend config"
}

output "dynamodb_table_name" {
  value       = module.dynamodb.table_name
  description = "DynamoDB table name"
}

output "lambda_function_name" {
  value       = module.lambda.function_name
  description = "Lambda function name"
}
