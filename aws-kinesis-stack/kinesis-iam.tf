resource "aws_iam_role_policy" "twitter_source_kinesis_policy" {
  name = "kinesis_policy"
  role = var.app_iam_role_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "kinesis:*",
      "Effect": "Allow",
      "Resource": "${aws_kinesis_stream.twitter_source.arn}"
    }
  ]
}
EOF
}
