output "arn" {
  value = aws_iam_role.role.arn
}

output "name" {
  value = aws_iam_role.role.name
}

output "path" {
  value = aws_iam_role.role.path
}

output "full_name" {
  value = "${aws_iam_role.role.path}${aws_iam_role.role.name}"
}

output "unique_id" {
  value = aws_iam_role.role.unique_id
}

