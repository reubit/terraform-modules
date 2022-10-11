resource "aws_kinesis_firehose_delivery_stream" "twitter_source" {
  count       = local.app_environment == local.app_static_environment ? 1 : 0
  name        = var.app_module_outputs["resource_names"]["aws_dot_delimited"]
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn           = aws_iam_role.twitter_source_firehose[0].arn
    bucket_arn         = var.s3_bucket_arn
    compression_format = "GZIP"
    prefix             = var.s3_bucket_prefix
  }

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.twitter_source.arn
    role_arn           = aws_iam_role.twitter_source_firehose[0].arn
  }
}
