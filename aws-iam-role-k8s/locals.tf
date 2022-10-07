locals {
  aws_region                 = var.aws_region != "" ? var.aws_region : lookup(var.common_variables, "aws_region", "eu-west-1")
  aws_account_id             = var.aws_account_id != "" ? var.aws_account_id : var.common_variables["aws_account_id"]
  aws_account_name           = var.aws_account_name != "" ? var.aws_account_name : var.common_variables["aws_account_name"]
  k8s_cluster_name           = var.k8s_cluster_name != "" ? var.k8s_cluster_name : lookup(var.common_variables, "k8s_cluster_name", "eks-${local.aws_account_name}")
  k8s_namespace              = var.k8s_namespace != "" ? var.k8s_namespace : lookup(var.common_variables,"k8s_namespace","${var.app_team}-${var.app_static_environment}")
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

  common_variables = {
    "aws_region"                 = local.aws_region
    "aws_account_id"             = local.aws_account_id
    "aws_account_name"           = local.aws_account_name
    "k8s_cluster_name"           = local.k8s_cluster_name
    "k8s_namespace"              = local.k8s_namespace
    "app_realm"                  = local.app_realm
    "app_account"                = local.app_account
    "app_aws_domain"             = local.app_aws_domain
    "app_owner_domain"           = local.app_owner_domain
    "app_environment"            = local.app_environment
    "app_static_environment"     = local.app_static_environment
    "app_team"                   = local.app_team
    "app_product"                = local.app_product
    "app_system"                 = local.app_system
    "app_component"              = local.app_component
    "app_instance"               = local.app_instance
    "docker_image_repo"          = local.docker_image_repo
    "docker_image_tag"           = local.docker_image_tag
    "ingress_path"               = local.ingress_path
    "ingress_host"               = local.ingress_host
    "ingress_dns_zone"           = local.ingress_dns_zone
    "gitlab_project_id"          = local.gitlab_project_id
    "gitlab_project_url"         = local.gitlab_project_url
    "gitlab_commit_ref_name"     = local.gitlab_commit_ref_name
    "gitlab_commit_sha"          = local.gitlab_commit_sha
    "gitlab_pipeline_id"         = local.gitlab_pipeline_id
    "gitlab_pipeline_url"        = local.gitlab_pipeline_url
    "gitlab_pipeline_user_login" = local.gitlab_pipeline_user_login
    "gitlab_pipeline_user_name"  = local.gitlab_pipeline_user_name
    "gitlab_pipeline_user_email" = local.gitlab_pipeline_user_email
  }

  aws_tags = {
    "app_environment"            = local.app_environment
    "app_static_environment"     = local.app_static_environment
    "app_team"                   = local.app_team
    "app_product"                = local.app_product
    "app_system"                 = local.app_system
    "app_component"              = local.app_component
    "app_instance"               = local.app_instance
    "gitlab_project_id"          = local.gitlab_project_id
    "gitlab_project_url"         = local.gitlab_project_url
    "gitlab_commit_ref_name"     = local.gitlab_commit_ref_name
    "gitlab_commit_sha"          = local.gitlab_commit_sha
    "gitlab_pipeline_id"         = local.gitlab_pipeline_id
    "gitlab_pipeline_url"        = local.gitlab_pipeline_url
    "gitlab_pipeline_user_login" = local.gitlab_pipeline_user_login
    "gitlab_pipeline_user_name"  = local.gitlab_pipeline_user_name
    "gitlab_pipeline_user_email" = local.gitlab_pipeline_user_email
  }

  k8s_service_name            = var.k8s_service_name != "" ? var.k8s_service_name : module.resource_names.k8s_resource
  eks_cluster_name            = var.eks_cluster_name != "" ? var.eks_cluster_name : join("", data.aws_cloudformation_export.eks_cluster_name.*.value)
  eks_oidc_issuer_url         = join("", data.aws_eks_cluster.cluster.*.identity.0.oidc.0.issuer)
  eks_oidc_issuer             = replace(local.eks_oidc_issuer_url, "https://", "")
  openid_connect_provider_arn = "arn:aws:iam::${local.aws_account_id}:oidc-provider/${local.eks_oidc_issuer}"

  assume_role_policy_blank_json      = "{\"Version\": \"2012-10-17\", \"Statement\": []}"
  assume_role_policy_ec2_json        = var.assume_role_policy_ec2_enabled ? data.aws_iam_policy_document.assume_role_policy_ec2.json : local.assume_role_policy_blank_json
  assume_role_policy_kube2iam_json   = var.assume_role_policy_kube2iam_enabled ? data.aws_iam_policy_document.assume_role_policy_kube2iam.json : local.assume_role_policy_blank_json
  assume_role_policy_iam_for_sa_json = var.assume_role_policy_iam_for_sa_enabled ? data.aws_iam_policy_document.assume_role_policy_iam_for_sa.json : local.assume_role_policy_blank_json

  derived_name = "${local.app_team}-${local.app_environment}.${local.app_system}.${local.app_component}${local.app_instance != "default" ? ".${local.app_instance}" : ""}${var.purpose != "" ? ".${var.purpose}" : ""}"
  name         = var.name_override != "" ? var.name_override : local.derived_name
}

