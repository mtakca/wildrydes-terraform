data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.trusted_services
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}

data "aws_iam_policy_document" "inline" {
  count = var.dynamodb_table_arn != "" ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:PutItem"]
    resources = [var.dynamodb_table_arn]
  }
}

resource "aws_iam_role_policy" "inline" {
  count  = var.dynamodb_table_arn != "" ? 1 : 0
  name   = "dynamodb-write"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.inline[0].json
}
