# Lambda Module

Node.js Lambda function with zip deployment and optional API Gateway permission.

## Usage

```hcl
module "lambda" {
  source = "../../modules/lambda"

  function_name             = "myapp-dev-handler"
  role_arn                  = module.iam.role_arn
  source_dir                = "${path.module}/../../modules/lambda/src"
  dynamodb_table_name       = module.dynamodb.table_name
  api_gateway_execution_arn = module.api_gateway.execution_arn
  environment               = "dev"
  tags                      = local.tags
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `function_name` | Function name | `string` | - |
| `role_arn` | Execution role ARN | `string` | - |
| `source_dir` | Source code path | `string` | - |
| `handler` | Handler | `string` | `index.handler` |
| `runtime` | Runtime | `string` | `nodejs20.x` |
| `timeout` | Timeout (seconds) | `number` | `10` |
| `memory_size` | Memory (MB) | `number` | `128` |

## Outputs

| Name | Description |
|------|-------------|
| `function_arn` | Function ARN |
| `invoke_arn` | Invoke ARN |
| `function_name` | Function name |
