module "aws-iam-role-k8s" {
  source = "git::https://github.com/reubit/terraform-modules.git//aws-iam-role-k8s"

  count = var.iam_role_create ? 1 : 0

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  assume_role_policy_kube2iam_enabled   = local.iam_role_kube2iam_enabled
  assume_role_policy_iam_for_sa_enabled = local.iam_role_service_accounts_enabled
  name_override                         = var.iam_role_name
}
