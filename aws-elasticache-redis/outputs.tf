output "id" {
  value = join("", aws_elasticache_replication_group.redis[*].id)
}

output "primary_endpoint_address" {
  value = join("", aws_elasticache_replication_group.redis[*].primary_endpoint_address)
}

output "member_clusters" {
  value = concat([], aws_elasticache_replication_group.redis[*].member_clusters)
}
