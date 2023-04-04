resource "kubernetes_service_account" "service_account" {
  metadata {
    name      = module.resource_names.k8s_resource
    namespace = local.k8s_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = var.iam_role_service_accounts_enabled ? "arn:aws:iam::${local.aws_account_id}:role/${local.iam_role_name}" : ""
    }
    labels = {
      "app_environment" = local.app_environment
      "app_team"        = local.app_team
      "app_product"     = local.app_product
      "app_system"      = local.app_system
      "app_component"   = local.app_component
    }
  }

  automount_service_account_token = true
}

resource "kubernetes_role" "role" {
  metadata {
    name      = module.resource_names.k8s_resource
    namespace = local.k8s_namespace
  }

  rule {
    api_groups = [""]
    resources  = ["pods","persistentvolumeclaims"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
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
    namespace = local.k8s_namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.service_account.metadata[0].name
    namespace = local.k8s_namespace
  }
}

