module "redis" {
  source = "git::https://github.com/reubit/terraform-modules.git//aws-elasticache-redis"

  enabled = var.elasticache_enabled

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Elasticache config
  apply_immediately = var.elasticache_apply_immediately
  node_type         = var.elasticache_node_type
  redis_version     = var.elasticache_redis_version
}

