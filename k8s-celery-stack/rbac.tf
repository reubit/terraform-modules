resource "kubernetes_service_account" "service_account" {
  metadata {
    name      = module.resource_names.k8s_resource
    namespace = local.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = var.iam_role_service_accounts_enabled ? "arn:aws:iam::${local.aws_account_id}:role/${local.iam_role_name}" : ""
    }
    labels = {
      "phx_environment" = local.environment
      "phx_team"        = local.team
      "phx_country"     = local.country
      "phx_sport"       = local.sport
      "phx_system"      = local.system
      "phx_component"   = local.component
    }
  }

  automount_service_account_token = true
}

resource "kubernetes_role" "role" {
  metadata {
    name      = module.resource_names.k8s_resource
    namespace = local.namespace
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch", "extensions"]
    resources  = ["jobs"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding" "role_binding" {
  metadata {
    name      = module.resource_names.k8s_resource
    namespace = local.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.service_account.metadata[0].name
    namespace = local.namespace
  }
}

