locals {
  # Define 'aws_long_name_parts' used to compose aws long name variables
  # Use name parts verbatim, excluding instance=default
  aws_long_name_parts = [
    local.app_team,
    local.app_product,
    local.app_system,
    local.app_component,
    local.app_instance == "default" ? "" : replace(local.app_instance, "/[[:^alnum:]]/", ""),
    local.app_environment,
  ]

  # Generate 'aws_resource_name_hash' based on sha256 of all name parts, concatenated at 7 chars
  aws_resource_name_hash = substr(sha256(join("/", compact(concat(local.k8s_long_name_parts,local.app_instance)))), 0, 7)

  # Define 'k8s_short_name_parts' used to compose 'k8s_short_name'.
  # Remove non-alphanumeric characters. Truncate env at 24 chars and parts at 3 chars. Append 'k8s_resource_name_hash' for uniqueness
  aws_short_name_parts = [
    substr(replace(local.app_team, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_team, "/[[:^alnum:]]/", "")), 3)),
    substr(replace(local.app_product, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_product, "/[[:^alnum:]]/", "")), 3)),
    substr(replace(local.app_system, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_system, "/[[:^alnum:]]/", "")), 3)),
    substr(replace(local.app_component, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_component, "/[[:^alnum:]]/", "")), 3)),
    local.app_instance == "default" ? "" : substr(replace(local.app_instance, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_instance, "/[[:^alnum:]]/", "")), 3)),
    substr(replace(local.app_environment, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_environment, "/[[:^alnum:]]/", "")), 3)),
    local.k8s_resource_name_hash,
  ]

  # Dot delimited name variant (IAM, Kinesis, S3, DynamoDB etc) - Use long name if <63 chars, otherwise use short name
  aws_dot_delimited_long  = join(".", compact(local.aws_long_name_parts))
  aws_dot_delimited_short = join(".", compact(local.aws_short_name_parts))
  aws_dot_delimited = length(local.aws_dot_delimited_long) <= 63 ? local.aws_dot_delimited_long : local.aws_dot_delimited_short

  # Dash delimited name variant (RDS, Elasticache, etc) - Use long name if <63 chars, otherwise use short name
  aws_dash_delimited_long  = join("-", compact(local.aws_long_name_parts))
  aws_dash_delimited_short = join("-", compact(local.aws_short_name_parts))
  aws_dash_delimited = length(local.aws_dash_delimited_long) <= 63 ? local.aws_dash_delimited_long : local.aws_dash_delimited_short

  # Define default aws tags dictionary
  aws_tags = {
    "app_environment"            = local.app_environment
    "app_static_environment"     = local.app_static_environment
    "app_team"                   = local.app_team
    "app_product"                = local.app_product
    "app_system"                 = local.app_system
    "app_component"              = local.app_component
    "app_instance"               = local.app_instance
    "gitlab_project_id"          = local.gitlab_project_id
    "gitlab_project_url"         = local.gitlab_project_url
    "gitlab_commit_ref_name"     = local.gitlab_commit_ref_name
    "gitlab_commit_sha"          = local.gitlab_commit_sha
    "gitlab_pipeline_id"         = local.gitlab_pipeline_id
    "gitlab_pipeline_url"        = local.gitlab_pipeline_url
    "gitlab_pipeline_user_login" = local.gitlab_pipeline_user_login
    "gitlab_pipeline_user_name"  = local.gitlab_pipeline_user_name
    "gitlab_pipeline_user_email" = local.gitlab_pipeline_user_email
  }
}
