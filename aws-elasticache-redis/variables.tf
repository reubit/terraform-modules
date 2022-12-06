variable "enabled" {
  default = true
}

variable "redis_port" {
  default = "6379"
}

variable "redis_replicas" {
  default = "2"
}

variable "redis_version" {
  default = "5.0.6"
}

variable "node_type" {
  default = "cache.t3.micro"
}

variable "automatic_failover_enabled" {
  default = true
}

variable "parameter_group_name" {
  default = "default.redis5.0"
}

variable "apply_immediately" {
  default = false
}

variable "maintenance_window" {
  default = "wed:00:00-wed:01:00"
}

variable "snapshot_window" {
  default = "23:00-00:00"
}

variable "snapshot_retention_limit" {
  default = "0"
}

