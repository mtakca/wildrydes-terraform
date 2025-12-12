# IAM Module

Generic IAM role with configurable trust policy and managed/inline policies.

## Usage

```hcl
module "iam" {
  source = "../../modules/iam"

  name               = "myapp-dev-lambda"
  dynamodb_table_arn = module.dynamodb.table_arn
  tags               = local.tags
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `name` | Role name | `string` | - |
| `trusted_services` | Services allowed to assume | `list(string)` | `["lambda.amazonaws.com"]` |
| `managed_policy_arns` | Managed policies to attach | `list(string)` | `[AWSLambdaBasicExecutionRole]` |
| `dynamodb_table_arn` | DynamoDB ARN for write policy | `string` | `""` |

## Outputs

| Name | Description |
|------|-------------|
| `role_arn` | Role ARN |
| `role_name` | Role name |
