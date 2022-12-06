variable "environment_variables" {
  default = {}
}

variable "working_dir" {
  default = ""
}

variable "iam_role_create" {
  default = true
}

variable "iam_role_name" {
  default = ""
}

variable "iam_role_kube2iam_enabled" {
  default = "false"
}

variable "iam_role_service_accounts_enabled" {
  default = "true"
}

variable "otel_exporter_otlp_endpoint" {
  default = "core-opentelemetry-collector.core"
}

variable "otel_python_flask_excluded_urls" {
  default = "healthcheck,metrics"
}

variable "security_context_json" {
  default     = "{\"runAsUser\": 2, \"runAsGroup\": 2, \"fsGroup\": 2}"
  description = "Default to running celery components as the 'daemon' user (uid=2)"
}
