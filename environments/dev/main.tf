terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.default_tags
  }
}

locals {
  default_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "cognito" {
  source = "../../modules/cognito"

  name        = "${var.project}-${var.environment}"
  environment = var.environment
  tags        = local.default_tags
}

module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name  = "${var.project}-${var.environment}-rides"
  environment = var.environment
  tags        = local.default_tags
}

module "iam" {
  source = "../../modules/iam"

  name               = "${var.project}-${var.environment}-lambda"
  dynamodb_table_arn = module.dynamodb.table_arn
  tags               = local.default_tags
}

module "lambda" {
  source = "../../modules/lambda"

  function_name             = "${var.project}-${var.environment}-request-unicorn"
  role_arn                  = module.iam.role_arn
  dynamodb_table_name       = module.dynamodb.table_name
  source_dir                = "${path.module}/../../modules/lambda/src"
  api_gateway_execution_arn = module.api_gateway.execution_arn
  environment               = var.environment
  tags                      = local.default_tags
}

module "api_gateway" {
  source = "../../modules/api-gateway"

  name                  = "${var.project}-${var.environment}"
  cognito_user_pool_arn = module.cognito.user_pool_arn
  lambda_invoke_arn     = module.lambda.invoke_arn
  lambda_function_name  = module.lambda.function_name
  stage_name            = var.environment
  tags                  = local.default_tags
}
