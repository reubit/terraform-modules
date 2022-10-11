output "kinesis_stream_name" {
  value = aws_kinesis_stream.twitter_source.name
}

output "kinesis_firehose_stream_name" {
  value = local.app_environment == local.app_static_environment ? aws_kinesis_firehose_delivery_stream.twitter_source[0].name : ""
}

output "kinesis_firehose_iam_role_name" {
  value = local.app_environment == local.app_static_environment ? aws_iam_role.twitter_source_firehose[0].name : ""
}
