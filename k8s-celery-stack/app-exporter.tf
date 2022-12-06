module "exporter" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  enabled = var.exporter_enabled

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  docker_image_repo = "ovalmoney/celery-exporter"
  docker_image_tag  = "1.4.0"

  instance = "exporter"

  # Deployment specific resources
  cpu_request    = "100m"
  cpu_limit      = "200m"
  memory_request = "128Mi"
  memory_limit   = "128Mi"

  # Deployment specific config
  service_port          = "9540"
  ingress_host          = local.ingress_host
  ingress_path          = "${local.ingress_path}exporter"
  fargate_enabled       = var.exporter_fargate_enabled
  healthcheck_path      = "/metrics"
  initial_delay_seconds = "10"
  timeout_seconds       = "2"
  period_seconds        = "30"
  datadog_metrics_list  = ["celery_*"]
  security_context_json = var.security_context_json

  k8s_resource_prepend_static_environment = var.k8s_resource_prepend_static_environment

  # Deployment specific environment variables
  environment_variables = {
    CELERY_EXPORTER_BROKER_URL = "redis://${local.redis_host}:6379/1"
  }
}

