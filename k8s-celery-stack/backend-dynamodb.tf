resource "aws_dynamodb_table" "celery_results_table" {
  count = var.dynamodb_table_enabled ? 1 : 0

  name           = local.dynamodb_name
  billing_mode   = "PROVISIONED"
  hash_key       = "id"
  read_capacity  = var.dynamodb_table_read_capacity
  write_capacity = var.dynamodb_table_write_capacity

  attribute {
    name = "id"
    type = "S"
  }

  ttl {
    enabled        = "true"
    attribute_name = "ttl"
  }

  timeouts {
    create = "1h"
    update = "1h"
    delete = "1h"
  }
}

resource "aws_iam_role_policy" "dynamodb_celery_results_policy" {
  count = var.dynamodb_table_enabled ? 1 : 0

  name = "dynamodb_celery_results_policy"
  role = local.iam_role_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "${aws_dynamodb_table.celery_results_table[0].arn}"
    }
  ]
}
EOF

}

