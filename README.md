# Wild Rydes Serverless Infrastructure

AWS serverless backend for Wild Rydes unicorn ride-sharing application.

## Architecture

```mermaid
flowchart LR
    subgraph Frontend
        A[Static Site<br/>Amplify]
    end
    subgraph Auth
        B[Cognito<br/>User Pool]
    end
    subgraph Backend
        C[API Gateway<br/>REST]
        D[Lambda<br/>RequestUnicorn]
        E[DynamoDB<br/>Rides]
    end
    
    A --> B
    A --> C
    C -->|JWT Auth| D
    D --> E
```

## Structure

```
.
├── environments/
│   └── dev/               # Development environment
├── modules/
│   ├── api-gateway/       # REST API + CORS
│   ├── cognito/           # User Pool + Client
│   ├── dynamodb/          # Rides table
│   ├── iam/               # Lambda execution role
│   └── lambda/            # RequestUnicorn function
└── static-site/           # Frontend (for Amplify deployment)
```

## Deployment

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## Future Roadmap

### Phase 1: Foundation (State & Security)
- [ ] **Remote Backend:** Migrate local state to S3 + DynamoDB for team collaboration and locking.
- [ ] **Security Hardening:** Implement AWS WAF for API Gateway and enable encryption at rest/transit everywhere.
- [ ] **OIDC Authentication:** Configure GitHub Actions OIDC for passwordless AWS access.

### Phase 2: Automation (CI/CD)
- [ ] **Pipeline:** Implement GitHub Actions workflow (Fmt -> Validate -> Plan -> Tfsec -> Apply).
- [ ] **Guardrails:** Add `checkov` or `tfsec` security scanning in PR checks.
- [ ] **Semantic Versioning:** Automate release tagging.

### Phase 3: Observability (Day-2 Ops)
- [ ] **Tracing:** Enable AWS X-Ray for end-to-end request tracing (Lambda <-> DynamoDB).
- [ ] **Monitoring:** Setup CloudWatch Alarms for Lambda error rates and API latency.
- [ ] **Structured Logging:** Implement Lambda PowerTools for JSON logging.

## Outputs

| Output | Description |
|--------|-------------|
| `api_invoke_url` | API Gateway endpoint |
| `cognito_user_pool_id` | User Pool ID |
| `cognito_client_id` | App Client ID |

## Frontend Config

Update `wildrydes-site/js/config.js` with Terraform outputs:

```js
window._config = {
    cognito: {
        userPoolId: '<cognito_user_pool_id>',
        userPoolClientId: '<cognito_client_id>',
        region: 'us-east-1'
    },
    api: {
        invokeUrl: '<api_invoke_url>'
    }
};
```

## Modules

| Module | Description |
|--------|-------------|
| [cognito](modules/cognito/) | User Pool + SPA Client |
| [dynamodb](modules/dynamodb/) | Rides table (PAY_PER_REQUEST) |
| [iam](modules/iam/) | Lambda execution role |
| [lambda](modules/lambda/) | RequestUnicorn function |
| [api-gateway](modules/api-gateway/) | REST API + Cognito authorizer |
