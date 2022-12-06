resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  count = var.enabled ? 1 : 0

  name       = module.resource_names.aws_dash_delimited
  subnet_ids = data.aws_subnets.subnets[0].ids
}

resource "aws_security_group" "redis_security_group" {
  count = var.enabled ? 1 : 0

  name        = module.resource_names.aws_dot_delimited
  description = module.resource_names.aws_dot_delimited
  vpc_id      = data.aws_eks_cluster.cluster[0].vpc_config[0].vpc_id
}

resource "aws_security_group_rule" "redis_ingress" {
  count = var.enabled ? 1 : 0

  type                     = "ingress"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  protocol                 = "tcp"
  source_security_group_id = data.aws_eks_cluster.cluster[0].vpc_config[0].cluster_security_group_id
  security_group_id        = aws_security_group.redis_security_group[0].id
}

resource "aws_elasticache_replication_group" "redis" {
  count = var.enabled ? 1 : 0

  replication_group_id          = module.resource_names.aws_dash_delimited
  replication_group_description = module.resource_names.aws_dash_delimited
  number_cache_clusters         = var.redis_replicas
  node_type                     = var.node_type
  automatic_failover_enabled    = var.automatic_failover_enabled
  engine_version                = var.redis_version
  port                          = var.redis_port
  parameter_group_name          = var.parameter_group_name
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group[0].id
  security_group_ids            = [aws_security_group.redis_security_group[0].id]
  apply_immediately             = var.apply_immediately
  maintenance_window            = var.maintenance_window
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
}
