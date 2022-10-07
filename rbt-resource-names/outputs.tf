output "k8s_resource" {
  value = local.k8s_resource_name
}

output "helm_release" {
  value = local.helm_release_name
}

output "aws_dot_delimited" {
  value = local.aws_dot_delimited
}

output "aws_dash_delimited" {
  value = local.aws_dash_delimited
}

output "aws_tags" {
  value = local.aws_tags
}
