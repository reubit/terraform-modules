module "redis-exporter" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  enabled = var.redis_exporter_enabled

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  docker_image_repo = "oliver006/redis_exporter"
  docker_image_tag  = "v1.11.1"

  app_instance = "redis-exporter"

  # Deployment specific resources
  cpu_request    = "100m"
  cpu_limit      = "200m"
  memory_request = "128Mi"
  memory_limit   = "128Mi"

  # Deployment specific config
  service_port          = "9121"
  ingress_host          = local.ingress_host
  ingress_path          = "${local.ingress_path}redis-exporter"
  fargate_enabled       = var.redis_exporter_fargate_enabled
  healthcheck_path      = "/metrics"
  initial_delay_seconds = "10"
  timeout_seconds       = "2"
  period_seconds        = "30"
  datadog_metrics_list  = ["redis_*"]
  security_context_json = var.security_context_json

  # Deployment specific environment variables
  environment_variables = {
    REDIS_ADDR                = "redis://${local.redis_host}:6379"
    REDIS_EXPORTER_CHECK_KEYS = "db1=*"
  }
}

