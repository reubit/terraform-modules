locals {
  aws_region                 = var.aws_region != "" ? var.aws_region : lookup(var.common_variables, "aws_region", "eu-west-1")
  aws_account_id             = var.aws_account_id != "" ? var.aws_account_id : var.common_variables["aws_account_id"]
  aws_account_name           = var.aws_account_name != "" ? var.aws_account_name : var.common_variables["aws_account_name"]
  k8s_cluster_name           = var.k8s_cluster_name != "" ? var.k8s_cluster_name : lookup(var.common_variables, "k8s_cluster_name", "eks-${local.aws_account_name}")
  k8s_namespace              = var.k8s_namespace != "" ? var.k8s_namespace : lookup(var.common_variables,"k8s_namespace","${var.app_team}-${var.app_static_environment}")
  app_org                    = var.app_org != "" ? var.app_realm : var.common_variables["app_org"]
  app_realm                  = var.app_realm != "" ? var.app_realm : var.common_variables["app_realm"]
  app_account                = var.app_account != "" ? var.app_account : var.common_variables["app_account"]
  app_aws_domain             = var.app_aws_domain != "" ? var.app_aws_domain : var.common_variables["app_aws_domain"]
  app_owner_domain           = var.app_owner_domain != "" ? var.app_owner_domain : lookup(var.common_variables, "app_owner_domain", var.app_aws_domain)
  app_environment            = var.app_environment != "" ? var.app_environment : var.common_variables["app_environment"]
  app_static_environment     = var.app_static_environment != "" ? var.app_static_environment : var.common_variables["app_static_environment"]
  app_team                   = var.app_team != "" ? var.app_team : var.common_variables["app_team"]
  app_product                = var.app_product != "" ? var.app_product : lookup(var.common_variables, "app_product", "default")
  app_system                 = var.app_system != "" ? var.app_system : var.common_variables["app_system"]
  app_component              = var.app_component != "" ? var.app_component : var.common_variables["app_component"]
  app_instance               = var.app_instance != "" ? var.app_instance : lookup(var.common_variables, "app_instance", "default")
  docker_image_repo          = var.docker_image_repo != "" ? var.docker_image_repo : var.common_variables["docker_image_repo"]
  docker_image_tag           = var.docker_image_tag != "" ? var.docker_image_tag : var.common_variables["docker_image_tag"]
  ingress_path               = var.ingress_path != "" ? var.ingress_path : (var.common_variables["ingress_path"] != "" ? var.common_variables["ingress_path"] : "/${local.app_component}/")
  ingress_host               = var.ingress_host != "" ? var.ingress_host : (var.common_variables["ingress_host"] != "" ? var.common_variables["ingress_host"] : "${local.app_product}-${local.app_system}-${local.app_environment}")
  ingress_dns_zone           = var.ingress_dns_zone != "" ? var.ingress_dns_zone : var.common_variables["ingress_dns_zone"]
  gitlab_project_id          = var.gitlab_project_id != "" ? var.gitlab_project_id : var.common_variables["gitlab_project_id"]
  gitlab_project_url         = var.gitlab_project_url != "" ? var.gitlab_project_url : var.common_variables["gitlab_project_url"]
  gitlab_commit_ref_name     = var.gitlab_commit_ref_name != "" ? var.gitlab_commit_ref_name : var.common_variables["gitlab_commit_ref_name"]
  gitlab_commit_sha          = var.gitlab_commit_sha != "" ? var.gitlab_commit_sha : var.common_variables["gitlab_commit_sha"]
  gitlab_pipeline_id         = var.gitlab_pipeline_id != "" ? var.gitlab_pipeline_id : var.common_variables["gitlab_pipeline_id"]
  gitlab_pipeline_url        = var.gitlab_pipeline_url != "" ? var.gitlab_pipeline_url : var.common_variables["gitlab_pipeline_url"]
  gitlab_pipeline_user_login = var.gitlab_pipeline_user_login != "" ? var.gitlab_pipeline_user_login : var.common_variables["gitlab_pipeline_user_login"]
  gitlab_pipeline_user_name  = var.gitlab_pipeline_user_name != "" ? var.gitlab_pipeline_user_name : var.common_variables["gitlab_pipeline_user_name"]
  gitlab_pipeline_user_email = var.gitlab_pipeline_user_email != "" ? var.gitlab_pipeline_user_email : var.common_variables["gitlab_pipeline_user_email"]

  is_non_prod = local.app_environment != "prod" ? "true" : "false"
}
