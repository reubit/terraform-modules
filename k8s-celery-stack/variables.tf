variable "log_level" {
  default = "INFO"
}

variable "celery_app_name" {
  default = "tasks.celery"
}

variable "celery_broker" {
  default = "redis"
}

variable "celery_result_backend" {
  default = "redis"
}

variable "api_enabled" {
  default = true
}

variable "api_min_replicas" {
  default     = ""
  description = "If not specified, defaults to 1 for dev environments and 3 for non-dev"
}

variable "api_max_replicas" {
  default = "12"
}

variable "api_memory_request" {
  default = "1Gi"
}

variable "api_memory_limit" {
  default = "1Gi"
}

variable "api_cpu_request" {
  default = "100m"
}

variable "api_cpu_limit" {
  default = "1"
}

variable "api_ingress_sub_path" {
  default = ""
}

variable "api_ingress_rewrite_target_enabled" {
  default = "false"
}

variable "api_custom_pod_annotations" {
  type    = map(string)
  default = {}
}

variable "api_custom_helm_values" {
  default = ""
}

variable "api_fargate_enabled" {
  default = false
}

variable "beat_enabled" {
  default = true
}

variable "beat_fargate_enabled" {
  default = false
}

variable "dynamodb_table_enabled" {
  default = false
}

variable "dynamodb_table_read_capacity" {
  default = "50"
}

variable "dynamodb_table_write_capacity" {
  default = "50"
}

variable "dynamodb_table_ttl_seconds" {
  default = "86400"
}

variable "exporter_enabled" {
  default = false
}

variable "exporter_fargate_enabled" {
  default = false
}

variable "flower_enabled" {
  default = true
}

variable "flower_ingress_sub_path" {
  default = "flower"
}

variable "flower_ingress_rewrite_target_enabled" {
  default = "false"
}

variable "flower_fargate_enabled" {
  default = false
}

variable "redis_exporter_enabled" {
  default = false
}

variable "redis_exporter_fargate_enabled" {
  default = false
}

variable "worker_enabled" {
  default = true
}

variable "worker_min_replicas" {
  default     = ""
  description = "If not specified, defaults to 1 for dev environments and 2 for non-dev"
}

variable "worker_max_replicas" {
  default = "6"
}

variable "worker_memory_request" {
  default = "2Gi"
}

variable "worker_memory_limit" {
  default = "2Gi"
}

variable "worker_cpu_request" {
  default = "2"
}

variable "worker_cpu_limit" {
  default = "2"
}

variable "worker_custom_pod_annotations" {
  type    = map(string)
  default = {}
}

variable "worker_custom_helm_values" {
  default = ""
}

variable "worker_fargate_enabled" {
  default = false
}

variable "worker_celery_args" {
  default = ["--autoscale=20,5"]
}

variable "rabbitmq_enabled" {
  default = false
}

variable "api_environment_variables" {
  default = {}
}

variable "worker_environment_variables" {
  default = {}
}

variable "elasticache_enabled" {
  default = true
}

variable "elasticache_apply_immediately" {
  default = true
}

variable "elasticache_redis_version" {
  default = "7.0"
}

variable "elasticache_node_type" {
  default = "cache.t3.micro"
}

variable "memorydb_enabled" {
  default = true
}

variable "memorydb_redis_port" {
  default = "6379"
}

variable "memorydb_auto_minor_version_upgrade" {
  default = true
}

variable "memorydb_engine_version" {
  default = "6.2"
}

variable "memorydb_node_type" {
  default = "db.t4g.small"
}

variable "memorydb_data_tiering" {
  default = false
}

variable "memorydb_num_shards" {
  default = 1
}

variable "memorydb_num_replicas_per_shard" {
  default = 1
}

variable "memorydb_snapshot_name" {
  default = null
}
