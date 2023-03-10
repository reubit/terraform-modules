output "docker_image_repo" {
  value = local.docker_image_repo
}

output "docker_image_tag" {
  value = local.docker_image_tag
}

output "iam_role_name" {
  value = local.iam_role_name
}

output "service_account_name" {
  value = module.resource_names.k8s_resource
}

output "redis_address" {
  value = local.redis_address
}

output "redis_db_address" {
  value = local.redis_db_address
}
