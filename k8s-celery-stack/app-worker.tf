module "worker" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  enabled = var.worker_enabled

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  app_instance = "worker"

  # Deployment specific resources
  cpu_request    = var.worker_cpu_request
  cpu_limit      = var.worker_cpu_limit
  memory_request = var.worker_memory_request
  memory_limit   = var.worker_memory_limit

  # Deployment specific config
  working_dir                       = var.working_dir
  autoscaling_enabled               = "true"
  autoscaling_min_replicas          = local.worker_min_replicas
  autoscaling_max_replicas          = var.worker_max_replicas
  service_enabled                   = "false"
  ingress_enabled                   = "false"
  fargate_enabled                   = var.worker_fargate_enabled
  iam_role_name                     = local.iam_role_name
  iam_role_create                   = false
  iam_role_service_accounts_enabled = var.iam_role_service_accounts_enabled
  iam_role_kube2iam_enabled         = var.iam_role_kube2iam_enabled
  service_account_create            = "false"
  service_account_name              = kubernetes_service_account.service_account.metadata[0].name
  healthcheck_command               = "celery -A ${var.celery_app_name} inspect ping -d celery@$HOSTNAME"
  initial_delay_seconds             = "10"
  timeout_seconds                   = "15"
  period_seconds                    = "30"
  custom_pod_annotations            = var.worker_custom_pod_annotations
  container_args                    = local.worker_container_args
  custom_helm_values                = var.worker_custom_helm_values
  environment_variables             = local.worker_environment_variables
  security_context_json             = var.security_context_json
  otel_exporter_otlp_endpoint       = var.otel_exporter_otlp_endpoint
  otel_python_flask_excluded_urls   = var.otel_python_flask_excluded_urls
}

