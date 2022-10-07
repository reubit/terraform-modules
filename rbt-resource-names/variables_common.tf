variable "common_variables" {
  type    = map(string)
  default = {}
}

variable "aws_account_id" {
  default = ""
}

variable "aws_account_name" {
  default = ""
}

variable "aws_region" {
  default = ""
}

variable "k8s_cluster_name" {
  default = ""
}

variable "k8s_namespace" {
  default = ""
}

variable "app_realm" {
  default = ""
}

variable "app_account" {
  default = ""
}

variable "app_aws_domain" {
  default = ""
}

variable "app_team" {
  default = ""
}

variable "app_product" {
  default = ""
}

variable "app_environment" {
  default = ""
}

variable "app_static_environment" {
  default = ""
}

variable "app_system" {
  default = ""
}

variable "app_component" {
  default = ""
}

variable "app_instance" {
  default = ""
}

variable "docker_image_repo" {
  default = ""
}

variable "docker_image_tag" {
  default = ""
}

variable "ingress_host" {
  default = ""
}

variable "ingress_path" {
  default = ""
}

variable "ingress_dns_zone" {
  default = ""
}

variable "gitlab_project_id" {
  default = ""
}

variable "gitlab_project_url" {
  default = ""
}

variable "gitlab_commit_ref_name" {
  default = ""
}

variable "gitlab_commit_sha" {
  default = ""
}

variable "gitlab_pipeline_id" {
  default = ""
}

variable "gitlab_pipeline_url" {
  default = ""
}

variable "gitlab_pipeline_user_login" {
  default = ""
}

variable "gitlab_pipeline_user_name" {
  default = ""
}

variable "gitlab_pipeline_user_email" {
  default = ""
}
