output "release_name" {
  value = module.resource_names.helm_release
}

output "release_namespace" {
  value = local.k8s_namespace
}

output "release_status" {
  value = join("", helm_release.app.*.status)
}

output "k8s_resource_name" {
  value = module.resource_names.k8s_resource
}

output "environment_variables" {
  value = local.environment_variables
}

output "docker_image_repo" {
  value = local.docker_image_repo
}

output "docker_image_tag" {
  value = local.docker_image_tag
}

output "service_account_name" {
  value = local.service_account_name
}

