resource "kubernetes_service_account" "service_account" {
  count = var.service_account_create ? 1 : 0

  metadata {
    name        = local.service_account_name
    namespace   = local.k8s_namespace
    annotations = local.service_account_annotations
    labels      = local.service_account_labels
  }

  automount_service_account_token = true
}

