data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  count = var.assume_role_policy_iam_for_sa_enabled ? 1 : 0
  name  = local.eks_cluster_name
}

data "aws_cloudformation_export" "nodegroup_role" {
  count = var.assume_role_policy_kube2iam_enabled ? 1 : 0
  name  = var.node_role_cfn_export_name
}

data "aws_cloudformation_export" "eks_cluster_name" {
  count = var.eks_cluster_name == "" ? 1 : 0
  name  = var.eks_cluster_cfn_export_name
}

data "aws_iam_policy_document" "assume_role_policy_ec2" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "assume_role_policy_kube2iam" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = [join("", data.aws_cloudformation_export.nodegroup_role.*.value)]
      type        = "AWS"
    }
  }
}

data "aws_iam_policy_document" "assume_role_policy_iam_for_sa" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${local.eks_oidc_issuer}:sub"
      values   = ["system:serviceaccount:${local.k8s_namespace}:${local.k8s_service_name}"]
    }
    principals {
      # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
      # force an interpolation expression to be interpreted as a list by wrapping it
      # in an extra set of list brackets. That form was supported for compatibility in
      # v0.11, but is no longer supported in Terraform v0.12.
      #
      # If the expression in the following list itself returns a list, remove the
      # brackets to avoid interpretation as a list of lists. If the expression
      # returns a single list item then leave it as-is and remove this TODO comment.
      identifiers = [local.openid_connect_provider_arn]
      type        = "Federated"
    }
  }
}

####
## NOTE:The below is a hacky solution that works with aws provider v2.*, for compatability with terraform v0.11
####

# data "aws_iam_policy_document" "assume_role_policy_merged_0" {
#   source_json   = local.assume_role_policy_ec2_json
#   override_json = local.assume_role_policy_kube2iam_json
# }

# data "aws_iam_policy_document" "assume_role_policy_merged_1" {
#   source_json   = data.aws_iam_policy_document.assume_role_policy_merged_0.json
#   override_json = local.assume_role_policy_iam_for_sa_json
# }

# data "aws_iam_policy_document" "assume_role_policy" {
#   source_json = data.aws_iam_policy_document.assume_role_policy_merged_1.json
# }

####
## NOTE: This only works with aws provider >v3, which isn't avaialbe in terraform v0.11
####
data "aws_iam_policy_document" "assume_role_policy" {
  source_policy_documents = [
    "${local.assume_role_policy_ec2_json}",
    "${local.assume_role_policy_kube2iam_json}",
    "${local.assume_role_policy_iam_for_sa_json}"
  ]
}
