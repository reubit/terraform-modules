locals {
  # Define 'helm_release_name' as 'k8s_resource_name'. No need to prefex with namespace since helm v3
  helm_release_name = local.k8s_resource_name
}
