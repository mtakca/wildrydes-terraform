# DynamoDB Module

On-demand DynamoDB table with configurable partition key and PITR.

## Usage

```hcl
module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name  = "myapp-dev-rides"
  environment = "dev"
  tags        = local.tags
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `table_name` | Table name | `string` | - |
| `hash_key` | Partition key | `string` | `RideId` |
| `billing_mode` | Billing mode | `string` | `PAY_PER_REQUEST` |
| `enable_point_in_time_recovery` | Enable PITR | `bool` | `true` |
| `deletion_protection` | Enable deletion protection | `bool` | `false` |

## Outputs

| Name | Description |
|------|-------------|
| `table_name` | Table name |
| `table_arn` | Table ARN |
