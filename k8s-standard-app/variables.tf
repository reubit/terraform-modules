variable "enabled" {
  default = true
}

variable "replica_count" {
  default = "1"
}

variable "cpu_request" {
  default = "100m"
}

variable "cpu_limit" {
  default = "200m"
}

variable "memory_request" {
  default = "128Mi"
}

variable "memory_limit" {
  default = "128Mi"
}

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

variable "secret_volume_mounts" {
  default = []
}

variable "config_map_volume_mounts" {
  default = []
}

variable "service_enabled" {
  default = "true"
}

variable "service_port" {
  default = "8080"
}

variable "healthcheck_path" {
  default = "/healthcheck"
}

variable "healthcheck_command" {
  default = ""
}

variable "initial_delay_seconds" {
  default = "60"
}

variable "timeout_seconds" {
  default = "2"
}

variable "period_seconds" {
  default = "10"
}

variable "liveness_probe_enabled" {
  default = "true"
}

variable "readiness_probe_enabled" {
  default = "true"
}

variable "ingress_enabled" {
  default = "true"
}

variable "ingress_class" {
  default = "nginx"
}

variable "ingress_rewrite_target_enabled" {
  default = "true"
}

variable "autoscaling_enabled" {
  default = "false"
}

variable "autoscaling_mode" {
  default = "hpa"
}

variable "autoscaling_min_replicas" {
  default = "2"
}

variable "autoscaling_max_replicas" {
  default = "12"
}

variable "autoscaling_cpu_target_percentage" {
  default = "75"
}

variable "autoscaling_scale_down_stabilization_window" {
  default = "300"
}

variable "autoscaling_scale_up_stabilization_window" {
  default = "0"
}

variable "autoscaling_vpa_update_mode" {
  default = "Off"
}

variable "prometheus_metrics_enabled" {
  default = "true"
}

variable "prometheus_metrics_port" {
  default = ""
}

variable "prometheus_metrics_path" {
  default = "/metrics"
}

variable "datadog_metrics_enabled" {
  default = "true"
}

variable "datadog_metrics_namespace" {
  default = ""
}

variable "datadog_metrics_list" {
  type = list(string)
  default = [
    "app_*",
  ]
}

variable "service_account_name" {
  default = ""
}

variable "service_account_create" {
  default = "true"
}

variable "service_account_custom_annotations" {
  type    = map(string)
  default = {}
}

variable "service_account_custom_labels" {
  type    = map(string)
  default = {}
}

variable "custom_deployment_annotations" {
  type    = map(string)
  default = {}
}

variable "custom_pod_annotations" {
  type    = map(string)
  default = {}
}

variable "custom_pod_labels" {
  type    = map(string)
  default = {}
}

variable "custom_helm_values" {
  default = ""
}

variable "helm_release_timeout" {
  default = "300"
}

variable "helm_release_atomic" {
  default = "false"
}

variable "fargate_enabled" {
  default = "false"
}

variable "pod_antiaffinity_preferred_node_enabled" {
  default = "true"
}

variable "pod_antiaffinity_preferred_node_weight" {
  default     = "10"
  description = "Set this higher to prefer unique nodes over zone spread"
}

variable "pod_antiaffinity_preferred_zone_enabled" {
  default = "true"
}

variable "pod_antiaffinity_preferred_zone_weight" {
  default     = "10"
  description = "Set this higher to prefer zone spread over unique nodes"
}

variable "pod_antiaffinity_required_node_enabled" {
  default     = "false"
  description = "Set this to force a unique node for every pod"
}

variable "pdb_enabled" {
  default = "true"
}

variable "pdb_max_unavailable" {
  default = "50%"
}

variable "otel_exporter_otlp_endpoint" {
  default = "core-opentelemetry-collector.core"
}

variable "otel_python_flask_excluded_urls" {
  default = "healthcheck,metrics"
}

variable "container_command" {
  default = []
}

variable "container_args" {
  default = []
}

variable "security_context_json" {
  default = "{}"
}
