variable "app_module_outputs" {
}

variable "s3_bucket_arn" {
}

variable "s3_bucket_prefix" {
}

variable "kinesis_shard_count" {
  default = "1"
}

variable "kinesis_retention_period" {
  default = "168"
}
