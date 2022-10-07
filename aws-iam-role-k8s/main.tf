resource "aws_iam_role" "role" {
  name               = local.role_name
  path               = var.path
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = local.aws_tags
}
