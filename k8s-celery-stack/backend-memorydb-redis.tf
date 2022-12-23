module "resource_names_memorydb" {
  source           = "git::https://github.com/reubit/terraform-modules.git//rbt-resource-names"
  common_variables = local.common_variables
  app_instance     = "memorydb"
}

module "memory_db" {
  source  = "terraform-aws-modules/memory-db/aws"
  version = "1.1.2"

  # Disable creation of cluster and all resources
  create = var.memorydb_enabled

  name                       = module.resource_names_memorydb.aws_dash_delimited
  description                = module.resource_names_memorydb.aws_dash_delimited
  engine_version             = var.memorydb_engine_version
  auto_minor_version_upgrade = var.memorydb_auto_minor_version_upgrade
  node_type                  = var.memorydb_node_type
  num_shards                 = var.memorydb_num_shards
  num_replicas_per_shard     = var.memorydb_num_replicas_per_shard

  create_acl               = false
  acl_name                 = "open-access"
  tls_enabled              = false
  security_group_ids       = [aws_security_group.memory_db[0].id]
  maintenance_window       = "sun:23:00-mon:01:30"
  snapshot_retention_limit = 1
  snapshot_window          = "05:00-09:00"
  snapshot_name            = var.memorydb_snapshot_name

  create_parameter_group      = true
  parameter_group_name        = module.resource_names_memorydb.aws_dash_delimited
  parameter_group_description = module.resource_names_memorydb.aws_dash_delimited
  parameter_group_family      = "memorydb_redis6"

  create_subnet_group      = true
  subnet_group_name        = module.resource_names_memorydb.aws_dash_delimited
  subnet_group_description = module.resource_names_memorydb.aws_dash_delimited
  subnet_ids               = data.aws_subnets.subnets[0].ids
}

resource "aws_security_group" "memory_db" {
  count       = var.memorydb_enabled ? 1 : 0
  name        = module.resource_names_memorydb.aws_dot_delimited
  description = module.resource_names_memorydb.aws_dot_delimited
  vpc_id      = data.aws_eks_cluster.cluster[0].vpc_config[0].vpc_id
}

resource "aws_security_group_rule" "memory_db" {
  count                    = var.memorydb_enabled ? 1 : 0
  type                     = "ingress"
  from_port                = var.memorydb_redis_port
  to_port                  = var.memorydb_redis_port
  protocol                 = "tcp"
  source_security_group_id = data.aws_eks_cluster.cluster[0].vpc_config[0].cluster_security_group_id
  security_group_id        = aws_security_group.memory_db[0].id
}

data "aws_eks_cluster" "cluster" {
  count = var.memorydb_enabled ? 1 : 0
  name  = local.k8s_cluster_name
}

data "aws_subnets" "subnets" {
  count = var.memorydb_enabled ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [data.aws_eks_cluster.cluster[0].vpc_config[0].vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*${var.k8s_cluster_name}*Private*"]
  }
}

