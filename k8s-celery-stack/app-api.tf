module "api" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  enabled = var.api_enabled

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  instance = "api"

  # Deployment specific resources
  cpu_request    = var.api_cpu_request
  cpu_limit      = var.api_cpu_limit
  memory_request = var.api_memory_request
  memory_limit   = var.api_memory_limit

  # Deployment specific config
  working_dir                       = var.working_dir
  ingress_host                      = local.ingress_host
  ingress_path                      = "${local.ingress_path}${var.api_ingress_sub_path}"
  ingress_rewrite_target_enabled    = var.api_ingress_rewrite_target_enabled
  autoscaling_enabled               = "true"
  autoscaling_min_replicas          = local.api_min_replicas
  autoscaling_max_replicas          = var.api_max_replicas
  fargate_enabled                   = var.api_fargate_enabled
  iam_role_name                     = local.iam_role_name
  iam_role_create                   = var.iam_role_create
  iam_role_service_accounts_enabled = var.iam_role_service_accounts_enabled
  iam_role_kube2iam_enabled         = var.iam_role_kube2iam_enabled
  service_account_create            = "false"
  service_account_name              = kubernetes_service_account.service_account.metadata[0].name
  initial_delay_seconds             = "5"
  environment_variables             = local.api_environment_variables
  custom_pod_annotations            = var.api_custom_pod_annotations
  custom_helm_values                = var.api_custom_helm_values
  security_context_json             = var.security_context_json
  otel_exporter_otlp_endpoint       = var.otel_exporter_otlp_endpoint
  otel_python_flask_excluded_urls   = var.otel_python_flask_excluded_urls
}
