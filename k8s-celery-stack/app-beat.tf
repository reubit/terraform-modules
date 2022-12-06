module "beat" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  enabled = var.beat_enabled

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  instance = "beat"

  # Deployment specific resources
  cpu_request    = "100m"
  cpu_limit      = "200m"
  memory_request = "256Mi"
  memory_limit   = "256Mi"

  # Deployment specific config
  working_dir                       = var.working_dir
  service_enabled                   = "false"
  ingress_enabled                   = "false"
  fargate_enabled                   = var.beat_fargate_enabled
  iam_role_name                     = local.iam_role_name
  iam_role_create                   = var.iam_role_create
  iam_role_service_accounts_enabled = var.iam_role_service_accounts_enabled
  iam_role_kube2iam_enabled         = var.iam_role_kube2iam_enabled
  service_account_create            = "false"
  service_account_name              = kubernetes_service_account.service_account.metadata[0].name
  liveness_probe_enabled            = "false"
  readiness_probe_enabled           = "false"
  environment_variables             = local.environment_variables
  security_context_json             = var.security_context_json
  otel_exporter_otlp_endpoint       = var.otel_exporter_otlp_endpoint
  otel_python_flask_excluded_urls   = var.otel_python_flask_excluded_urls

  container_command = [
    "/bin/bash",
    "-c",
    "celery -A ${var.celery_app_name} beat --loglevel=${var.log_level} -s /celerybeat/celerybeat-schedule --pidfile=/celerybeat/celerybeat.pid",
  ]

  custom_helm_values = <<VALUES
deployment:
  volumes:
  - name: celerybeat
    emptyDir: {}
  volumeMounts:
  - mountPath: /celerybeat
    name: celerybeat

VALUES

}

