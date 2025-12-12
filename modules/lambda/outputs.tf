output "function_arn" {
  value       = aws_lambda_function.this.arn
  description = "Lambda function ARN"
}

output "invoke_arn" {
  value       = aws_lambda_function.this.invoke_arn
  description = "Lambda invoke ARN for API Gateway"
}

output "function_name" {
  value       = aws_lambda_function.this.function_name
  description = "Lambda function name"
}

output "qualified_arn" {
  value       = aws_lambda_function.this.qualified_arn
  description = "Lambda qualified ARN with version"
}
