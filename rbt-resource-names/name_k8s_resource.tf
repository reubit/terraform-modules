locals {
  # Define 'k8s_environment_prefix' to be prepended to resource names. Remove non-alphanumeric characters for dynamic environments
  k8s_environment_prefix = local.app_environment != local.app_static_environment ? replace(local.app_environment, "/[[:^alnum:]]/", "") : ""

  # Generate 'k8s_resource_name_hash' based on sha256 of all unmodified name parts, concatenated at 7 chars
  k8s_resource_name_hash = substr(sha256("${local.app_environment}-${local.app_product}-${local.app_system}-${local.app_component}-${local.app_instance}"), 0, 7)

  # Define 'k8s_long_name_parts' used to compose 'k8s_long_name'.
  # Use name parts verbatim, excluding instance=default
  k8s_long_name_parts = [
    local.k8s_environment_prefix,
    local.app_product,
    local.app_system,
    local.app_component,
    local.app_instance == "default" ? "" : replace(local.app_instance, "/[[:^alnum:]]/", ""),
  ]

  # Define 'k8s_short_name_parts' used to compose 'k8s_short_name'.
  # Remove non-alphanumeric characters. Truncate env at 24 chars and parts at 3 chars. Append 'k8s_resource_name_hash' for uniqueness
  k8s_short_name_parts = [
    substr(local.k8s_environment_prefix, 0, min(length(local.k8s_environment_prefix), 24)),
    substr(replace(local.app_product, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_product, "/[[:^alnum:]]/", "")), 3)),
    substr(replace(local.app_system, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_system, "/[[:^alnum:]]/", "")), 3)),
    substr(replace(local.app_component, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_component, "/[[:^alnum:]]/", "")), 3)),
    local.app_instance == "default" ? "" : substr(replace(local.app_instance, "/[[:^alnum:]]/", ""), 0, min(length(replace(local.app_instance, "/[[:^alnum:]]/", "")), 3)),
    local.k8s_resource_name_hash,
  ]

  # Compose 'k8s_long_name' and 'k8s_short_name' from compacted parts, delimited by '-'
  k8s_long_name  = join("-", compact(local.k8s_long_name_parts))
  k8s_short_name = join("-", compact(local.k8s_short_name_parts))

  # Use 'k8s_long_name' for resource name if under the 53 char helm release name limit, otherwise use 'k8s_short_name'
  k8s_resource_name = length(local.k8s_long_name) <= 53 ? local.k8s_long_name : local.k8s_short_name
}
