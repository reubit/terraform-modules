output "k8s_resource" {
  value = local.k8s_resource_name
}

output "helm_release" {
  value = local.helm_release_name
}

output "aws_dash_delimited" {
  value = local.aws_dash_delimited
}

output "aws_dot_delimited" {
  value = local.aws_dot_delimited
}

output "aws_slash_delimited" {
  value = local.aws_slash_delimited
}

output "aws_s3_bucket" {
  value = local.aws_s3_bucket
}

output "aws_tags" {
  value = local.aws_tags
}
