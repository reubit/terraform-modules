# Reubit Resource Names Module (rbt-resource-names)

## Table of Contents

1. [What This Module Provides](#whatitprovides)
1. [Module Version/Tag Information](#version)
1. [Notes](#notes)
1. [Module Inputs/Variables](#variables)
1. [Sample Usage](#howto)

## What This Module Provides <a name="whatitprovides"></a>

- This module represents the source of truth for cloud resource naming conventions
- A standard interface for generating resource names following code-defined naming conventions
- Given the provided project metadata variables (common_variables), this module will output the appropriate resource name for any given resource (E.g. k8s_resource, helm_release, iam_role, etc.)

Names are composes as follows:

- `k8s_resource`
  - If `long_name` <= 53 chars, use `long_name`. Otherwise, use `short_name`
  - `long_name` = `[<env_prefix-]<product>-<system>-<component>[-<instance>]`
  - `short_name` = `[<env_prefix|24>-]<product|3>-<system|3>-<component|3>[-<instance|3>]-<hash>`
    - `env_prefix` is chopped at 24 characters
    - Other name parts are chopped at 3 characters
    - A 7 character hash is appended to the end to ensure uniqueness
    - Maximum possible length is 53 characters
  - Notes
    - `env_prefix` - Only prepended for dynamic dev, with non-alphanumeric characters are filtered out
    - `instance` - Excluded if `instance == 'default'`
- `helm_release`
  - `helm_release` = `k8s_resource`
  - Since helm v3 release names are now namespaced, namespace prefix is no longer needed

## Module Version/Tag Information <a name="version"></a>

- `rbt-resource-names.v1.0.0`: Initial release
  - Provides `k8s_resource` output
  - Provides `helm_release` output

## Notes <a name="notes"></a>

- **IMPORTANT**: Use of this module requires that your `terraform` directory contains the latest version of `common.tf`
  - Specifically, it requires the `local.common_variables` map to be defined.
  - Latest version of `common.tf` can be found here: <https://github.com/reubit/cicd-resources/blob/master/terraform/common.tf>

## Module Inputs/Variables <a name="variables"></a>

### Common Variables (provided by the pipeline)

All common variables below are defined in your project's `common.tf` file. The values of these variables are set by the GitLab pipeline.

`common_variables` is the only required variable, and should be set to the value of `${local.common_variables}`. Only specify other common variables if you wish to override the pipeline-provided value for that specific variable.

The most common case for specifying an override value for the variables below is `instance`, where you may want to define multiple instances of your app in a single deployment.

- **common_variables**
  - This should be set to the value of `${local.common_variables}` (defined in your `common.tf`)
  - `${local.common_variables}` is a map of all variables below.
  - If this variable is set, all variables below are unnecessary, but can be used to override individual values.
- aws_region
- aws_account_id
- aws_account_name
- k8s_cluster_name
- k8s_namespace
- app_realm
- app_account
- app_aws_domain
- app_environment
- app_static_environment
- app_team
- app_product
- app_system
- app_component
- app_instance
- docker_image_repo
- docker_image_tag
- ingress_host_dns_zone
- ingress_host_include_environment
- gitlab_project_id
- gitlab_project_url
- gitlab_commit_ref_name
- gitlab_commit_sha
- gitlab_pipeline_id
- gitlab_pipeline_url
- gitlab_pipeline_user_login
- gitlab_pipeline_user_name
- gitlab_pipeline_user_email

## Sample Usage <a name="howto"></a>

### Helm release name

```hcl
module "resource_names" {
  source = "git::git::https://github.com/reubit/terraform-modules.git//k8s-resource-names"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables
}

resource "helm_release" "app" {
  name      = module.resource_names.helm_release
  chart     = "dummy/chart"
  version   = "1.0.0"
  namespace = var.namespace

  values = [
    var.helm_values
  ]
}
```

### K8S ConfigMap name

```hcl
module "resource_names" {
  source = "git::git::https://github.com/reubit/terraform-modules.git//k8s-resource-names"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables
}

resource "kubernetes_config_map" "conf_directory" {
  metadata {
    name      = module.resource_names.k8s_resource
    namespace = var.namespace
  }

  data {
    "app.properties" = data.template_file.app_properties.rendered
    "log4j2.xml"     = data.template_file.log4j2_xml.rendered
  }
}

```
