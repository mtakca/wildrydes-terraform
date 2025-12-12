# Cognito Module

Cognito User Pool with SPA client for serverless authentication.

## Usage

```hcl
module "cognito" {
  source = "../../modules/cognito"

  name        = "myapp-dev"
  environment = "dev"
  tags        = local.tags
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `name` | User pool name | `string` | - |
| `environment` | Environment identifier | `string` | - |
| `password_min_length` | Minimum password length | `number` | `8` |
| `access_token_validity_hours` | Access token validity | `number` | `1` |
| `refresh_token_validity_days` | Refresh token validity | `number` | `30` |

## Outputs

| Name | Description |
|------|-------------|
| `user_pool_id` | User Pool ID |
| `user_pool_arn` | User Pool ARN |
| `client_id` | App Client ID |
