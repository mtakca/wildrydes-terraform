output "invoke_url" {
  value       = aws_api_gateway_stage.this.invoke_url
  description = "API Gateway invoke URL"
}

output "api_id" {
  value       = aws_api_gateway_rest_api.this.id
  description = "API Gateway ID"
}

output "execution_arn" {
  value       = aws_api_gateway_rest_api.this.execution_arn
  description = "API Gateway execution ARN"
}

output "stage_name" {
  value       = aws_api_gateway_stage.this.stage_name
  description = "Deployment stage name"
}
