module "resource_names" {
  source = "git::https://github.com/reubit/terraform-modules.git//rbt-resource-names"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables
}
