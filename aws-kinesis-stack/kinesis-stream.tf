resource "aws_kinesis_stream" "twitter_source" {
  name                = var.app_module_outputs["resource_names"]["aws_dot_delimited"]
  shard_count         = var.kinesis_shard_count
  retention_period    = var.kinesis_retention_period
  shard_level_metrics = ["IncomingBytes","OutgoingBytes",]
}
