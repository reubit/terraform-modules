resource "helm_release" "app" {
  count = var.enabled ? 1 : 0

  name             = module.resource_names.helm_release
  chart            = "${path.module}/charts/k8s-standard-app"
  version          = "1.0.0"
  namespace        = local.k8s_namespace
  timeout          = var.helm_release_timeout
  atomic           = var.helm_release_atomic
  create_namespace = var.create_namespace

  set {
    name  = "deployment.image.repository"
    value = local.docker_image_repo
  }

  set {
    name  = "deployment.image.tag"
    value = local.docker_image_tag
  }

  values = [
    local.helm_values,
    var.custom_helm_values,
  ]
}
