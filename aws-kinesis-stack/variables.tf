variable "app_resource_names" {
}

variable "app_iam_role_name" {
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
