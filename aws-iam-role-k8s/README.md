# Reubit AWS IAM Role for K8S Module (aws-iam-role-k8s)

## Table of Contents

1. [What This Module Provides](#whatitprovides)
1. [Prerequisites](#prerequisites)
1. [Module Version/Tag Information](#version)
1. [Module Inputs/Variables](#variables)
1. [Module Outputs](#outputs)
1. [Sample Usage](#howto)

## What This Module Provides <a name="whatitprovides"></a>

- Deploys an AWS IAM Role for use with an app running in K8S/EKS
- Supports roles using either kube2iam or IAM for Service Accounts
- IAM roles are tagged with all relevant data in the `common_variables` map

## Prerequisites <a name="prerequisites"></a>

- <span style="color:red">**IAM for Service Accounts requires that you use a newer AWS SDK. Try to use the latest available.**</span>

## Module Version/Tag Information <a name="version"></a>

- `aws-iam-role-k8s.v1.0.0`: Initial release

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

### App Deployment Config Variables

All of the following variables are optional, each with pre-defined sane defaults.

| Variable Name                               | Type   | Default Value                                      |
| ------------------------------------------- | ------ | -------------------------------------------------- |
| `purpose`                                   | string | `""`                                               |
| `name_override`                             | string | `""`                                               |
| `path`                                      | string | `"/"`                                              |
| `assume_role_policy_ec2_enabled`            | bool   | `"false"`                                          |
| `assume_role_policy_kube2iam_enabled`       | bool   | `"false"`                                          |
| `assume_role_policy_iam_for_sa_enabled`     | bool   | `"true"`                                           |
| `eks_cluster_cfn_export_name`               | int    | `"cp-core-eks-cluster::ClusterName"`               |
| `k8s_service_name`                          | int    | *derived from common_variables*                    |
| `node_role_cfn_export_name`                 | string | `"cp-core-eks-nodegroup-default-NodeInstanceRole"` |

## Module Outputs <a name="outputs"></a>

This module generate the following outputs.

| Variable Name    | Type   | Description                                        |
| -----------------| ------ | -------------------------------------------------- |
| `arn`            | string | The AWS ARN of the created role                    |
| `name`           | string | The name of the created role                       |
| `path`           | string | The Iam path of the created role                   |
| `full_name`      | string | `<path>/<name>`                                    |
| `unique_id`      | string | The AWS generated unique id of the created role    |

## Sample Usage <a name="howto"></a>

### Basic Usage

Provisions an IAM Role for a Kubernetes app using a trust policy supporting IAM for Service Accounts.

```hcl
module "aws-iam-role-k8s" {
  source = "git:https://github.com/reubit/terraform-modules.git//aws-iam-role-k8s"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables
}
```

### Using kube2iam (Not Recommended)

You should try to stick to the default behavior which is to use IAM for Service Accounts. 

If you need to use Kube2iam, in your `k8s-standard-app` configuration (usually in `app.tf`), set the input `iam_role_kube2iam_enabled` to `true` and `iam_role_service_accounts_enabled` to `false` in addition to the `iam_role_name` that you set.
