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

  common_variables = {
    "aws_region"                 = local.aws_region
    "aws_account_id"             = local.aws_account_id
    "aws_account_name"           = local.aws_account_name
    "k8s_cluster_name"           = local.k8s_cluster_name
    "k8s_namespace"              = local.k8s_namespace
    "app_org"                    = local.app_org
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

  iam_role_name = var.iam_role_name != "" ? var.iam_role_name : (var.iam_role_create ? module.aws-iam-role-k8s[0].name : "")
  dynamodb_name = "${module.resource_names.aws_dot_delimited}.celery-results"
  rabbitmq_name = "${module.resource_names.k8s_resource}-rabbitmq"
  redis_host    = module.redis.primary_endpoint_address

  celery_broker_uris = {
    "redis"    = "redis://${local.redis_host}:6379/1"
    "rabbitmq" = "amqp://celery:celery@${local.rabbitmq_name}:5672//"
  }

  celery_result_backend_uris = {
    "redis"    = "redis://${local.redis_host}:6379/2"
    "dynamodb" = "dynamodb://@${local.aws_region}/${join("", aws_dynamodb_table.celery_results_table.*.name)}?read=${var.dynamodb_table_read_capacity}&write=${var.dynamodb_table_write_capacity}&ttl_seconds=${var.dynamodb_table_ttl_seconds}"
  }

  default_environment_variables = {
    K8S_RESOURCE_NAME     = module.resource_names.k8s_resource
    K8S_NAMESPACE         = local.k8s_namespace
    API_BASE_URL          = "https://${local.ingress_host}.${local.ingress_dns_zone}${local.ingress_path}${var.api_ingress_sub_path}"
    API_PREFIX            = "${local.ingress_path}${var.api_ingress_sub_path}"
    LOGLEVEL              = var.log_level
    REDIS_HOST            = local.redis_host
    RABBITMQ_HOST         = local.rabbitmq_name
    DYNAMODB_TABLE_NAME   = local.dynamodb_name
    CELERY_BROKER         = local.celery_broker_uris[var.celery_broker]
    CELERY_RESULT_BACKEND = local.celery_result_backend_uris[var.celery_result_backend]
  }

  default_api_environment_variables = {
    GUNICORN_LOGLEVEL = lower(var.log_level)
  }

  default_worker_environment_variables = {
    OTEL_AUTO_INSTRUMENT                  = "true"
    OTEL_PYTHON_DISABLED_INSTRUMENTATIONS = ""
  }

  environment_variables = merge(
    local.default_environment_variables,
    var.environment_variables,
  )
  api_environment_variables = merge(
    local.environment_variables,
    local.default_api_environment_variables,
    var.api_environment_variables,
  )
  worker_environment_variables = merge(
    local.environment_variables,
    local.default_worker_environment_variables,
    var.worker_environment_variables,
  )

  celery_worker_command = ["celery -A ${var.celery_app_name} worker --loglevel=${var.log_level}"]
  worker_container_args = concat(local.celery_worker_command, var.worker_celery_args)

  default_api_min_replicas    = local.app_static_environment == "dev" ? 1 : 3
  default_worker_min_replicas = local.app_static_environment == "dev" ? 1 : 2

  api_min_replicas    = var.api_min_replicas != "" ? var.api_min_replicas : local.default_api_min_replicas
  worker_min_replicas = var.worker_min_replicas != "" ? var.worker_min_replicas : local.default_worker_min_replicas
}

