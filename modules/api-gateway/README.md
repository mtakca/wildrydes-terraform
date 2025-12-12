# API Gateway Module

REST API with Cognito authorizer, Lambda proxy integration, and CORS support.

## Usage

```hcl
module "api_gateway" {
  source = "../../modules/api-gateway"

  name                  = "myapp-dev"
  cognito_user_pool_arn = module.cognito.user_pool_arn
  lambda_invoke_arn     = module.lambda.invoke_arn
  lambda_function_name  = module.lambda.function_name
  stage_name            = "dev"
  tags                  = local.tags
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `name` | API name | `string` | - |
| `cognito_user_pool_arn` | Cognito ARN | `string` | - |
| `lambda_invoke_arn` | Lambda invoke ARN | `string` | - |
| `stage_name` | Stage name | `string` | `dev` |
| `endpoint_type` | Endpoint type | `string` | `REGIONAL` |
| `resource_path` | Resource path | `string` | `ride` |

## Outputs

| Name | Description |
|------|-------------|
| `invoke_url` | API invoke URL |
| `execution_arn` | Execution ARN |
