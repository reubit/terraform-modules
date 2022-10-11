resource "aws_iam_role" "twitter_source_firehose" {
  count = local.app_environment == local.app_static_environment ? 1 : 0
  name  = "${var.app_resource_names.aws_dot_delimited}.firehose"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "twitter_source_firehose" {
  count = local.app_environment == local.app_static_environment ? 1 : 0
  name  = "kinesis_and_s3_policy"
  role  = aws_iam_role.twitter_source_firehose[0].name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "${var.s3_bucket_arn}",
        "${var.s3_bucket_arn}/*"
      ]
    },
    {
      "Action": "kinesis:*",
      "Effect": "Allow",
      "Resource": "${aws_kinesis_stream.twitter_source.arn}"
    }
  ]
}
EOF
}
