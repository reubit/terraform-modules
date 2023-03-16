module "flower" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  enabled = var.flower_enabled

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  app_instance = "flower"

  # Deployment specific resources
  cpu_request    = "100m"
  cpu_limit      = "200m"
  memory_request = "256Mi"
  memory_limit   = "256Mi"

  # Deployment specific config
  working_dir                       = var.working_dir
  service_port                      = "5555"
  ingress_host                      = local.ingress_host
  ingress_path                      = "${local.ingress_path}${var.flower_ingress_sub_path}"
  ingress_rewrite_target_enabled    = var.flower_ingress_rewrite_target_enabled
  healthcheck_path                  = "${local.ingress_path}${var.flower_ingress_sub_path}/"
  initial_delay_seconds             = "10"
  timeout_seconds                   = "2"
  period_seconds                    = "30"
  fargate_enabled                   = var.flower_fargate_enabled
  iam_role_name                     = local.iam_role_name
  iam_role_create                   = false
  iam_role_service_accounts_enabled = var.iam_role_service_accounts_enabled
  iam_role_kube2iam_enabled         = var.iam_role_kube2iam_enabled
  service_account_create            = "false"
  service_account_name              = kubernetes_service_account.service_account.metadata[0].name
  environment_variables             = local.environment_variables
  security_context_json             = var.security_context_json
  otel_exporter_otlp_endpoint       = var.otel_exporter_otlp_endpoint
  otel_python_flask_excluded_urls   = var.otel_python_flask_excluded_urls

  container_command = [
    "/bin/bash",
    "-c",
    "celery -A ${var.celery_app_name} flower --address=0.0.0.0 --port=5555 --url_prefix=${local.ingress_path}${var.flower_ingress_sub_path} --purge_offline_workers=30",
  ]
}

