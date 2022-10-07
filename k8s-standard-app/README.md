# Reubit Standard K8S App Module (k8s-standard-app)

## Table of Contents

1. [What This Module Provides](#whatitprovides)
1. [Module Version/Tag Information](#version)
1. [Notes](#notes)
1. [Module Inputs/Variables](#variables)
1. [Sample Usage](#howto)

## What This Module Provides <a name="whatitprovides"></a>

- Deploys a Docker containers as a kubernetes deployment following certain standard conventions
- Provides a simple but extensible interface, allowing for advanced customisation

## Module Version/Tag Information <a name="version"></a>

- `k8s-standard-app.v1.0.0`: Initial release

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

### App Deployment Config Variables <a name="app-deployment-config-variables"></a>

All of the following variables are optional, each with pre-defined sane defaults.

| Variable Name                                 | Type   | Default Value                                 |
| --------------------------------------------- | ------ | --------------------------------------------- |
| `replica_count`                               | string | `"1"`                                         |
| `cpu_request`                                 | string | `"100m"`                                      |
| `cpu_limit`                                   | string | `"200m"`                                      |
| `memory_request`                              | string | `"128Mi"`                                     |
| `memory_limit`                                | string | `"128Mi"`                                     |
| `environment_variables`                       | map    | `{}`                                          |
| `working_dir`                                 | string | `""`                                          |
| `iam_role_create`                             | bool   | `true`                                        |
| `iam_role_name`                               | string | `""`                                          |
| `iam_role_kube2iam_enabled`                   | string | `"false"`                                     |
| `iam_role_service_accounts_enabled`           | string | `"true"`                                      |
| `secret_volume_mounts`                        | list   | `[]`                                          |
| `config_map_volume_mounts`                    | list   | `[]`                                          |
| `service_enabled`                             | string | `"true"`                                      |
| `service_port`                                | string | `"8080"`                                      |
| `healthcheck_path`                            | string | `"/healthcheck"`                              |
| `healthcheck_command`                         | string | `""`                                          |
| `initial_delay_seconds`                       | string | `"60"`                                        |
| `timeout_seconds`                             | string | `"2"`                                         |
| `period_seconds`                              | string | `"10"`                                        |
| `liveness_probe_enabled`                      | string | `"true"`                                      |
| `readiness_probe_enabled`                     | string | `"true"`                                      |
| `ingress_enabled`                             | string | `"true"`                                      |
| `ingress_host`                                | string | `<system>-<environment>`                      |
| `ingress_path`                                | string | `/<component>/`                               |
| `ingress_class`                               | string | `"nginx"`                                     |
| `ingress_rewrite_target_enabled`              | string | `"true"`                                      |
| `autoscaling_enabled`                         | string | `"false"`                                     |
| `autoscaling_mode`                            | string | `"hpa"`                                       |
| `autoscaling_min_replicas`                    | string | `"2"`                                         |
| `autoscaling_max_replicas`                    | string | `"12"`                                        |
| `autoscaling_cpu_target_percentage`           | string | `"75"`                                        |
| `autoscaling_scale_down_stabilization_window` | string | `"300"`                                       |
| `autoscaling_scale_up_stabilization_window`   | string | `"0"`                                         |
| `autoscaling_vpa_update_mode`                 | string | `"Off"`                                       |
| `prometheus_metrics_enabled`                  | string | `"true"`                                      |
| `prometheus_metrics_port`                     | string | `<service_port>`                              |
| `prometheus_metrics_path`                     | string | `"/metrics"`                                  |
| `datadog_metrics_enabled`                     | string | `"true"`                                      |
| `datadog_metrics_namespace`                   | string | `<product>.<system>.<component>[.<instance>]` |
| `datadog_metrics_list`                        | list   | `["apps_*"]`                                  |
| `service_account_name`                        | string | `""`                                          |
| `service_account_create`                      | string | `"true"`                                      |
| `service_account_custom_annotations`          | map    | `{}`                                          |
| `service_account_custom_labels`               | map    | `{}`                                          |
| `custom_deployment_annotations`               | map    | `{}`                                          |
| `custom_pod_annotations`                      | map    | `{}`                                          |
| `custom_pod_labels`                           | map    | `{}`                                          |
| `custom_helm_values`                          | string | `""`                                          |
| `helm_release_timeout`                        | string | `"300"`                                       |
| `helm_release_atomic`                         | string | `"true"`                                      |
| `fargate_enabled`                             | string | `"false"`                                     |
| `pod_antiaffinity_preferred_node_enabled`     | string | `"true"`                                      |
| `pod_antiaffinity_preferred_node_weight`      | string | `"10"`                                        |
| `pod_antiaffinity_preferred_zone_enabled`     | string | `"true"`                                      |
| `pod_antiaffinity_preferred_zone_weight`      | string | `"10"`                                        |
| `pod_antiaffinity_required_node_enabled`      | string | `"false"`                                     |
| `pdb_enabled`                                 | string | `"true"`                                      |
| `pdb_max_unavailable`                         | string | `"50%"`                                       |
| `otel_exporter_otlp_endpoint`                 | string | `"core-opentelemetry-collector.core"`         |
| `otel_python_flask_excluded_urls`             | string | `"healthcheck,metrics"`                       |
| `container_command`                           | list   | `[]`                                          |
| `container_args`                              | list   | `[]`                                          |
| `security_context_json`                       | string | `"{}"`                                        |

## Sample Usage <a name="howto"></a>

### Basic usage

Define a basic deployment using all default values. This will deploy a single docker container defined by the pipeline-provided values in `common_variables`, and also defines a single environment variable.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Specifying custom replica count

Deploy `2` replicas of your container.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  replica_count = "2"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Specifying custom resource requests/limits

This example would override your container's resource allocations to the following:

- **cpu_request** - Increase to `500m` (500 millicores / 0.5 cores) from default of `100m`
- **cpu_limit** - Increase to `1` (1000 millicores / 1 core) from default of `200m`
- **memory_request** - Increase to `256Mi` from default of `128Mi`
- **memory_limit** - Increase to `256Mi` from default of `128Mi`

**NOTE:** It is STRONGLY recommended that you set `memory_request = memory_limit`

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  cpu_request    = "500m"
  cpu_limit      = "1"
  memory_request = "256Mi"
  memory_limit   = "256Mi"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Specify iam role

The below example assumes you've already defined an iam role module instance named `module.k8s_iam_role`, and a DynamoDB table resource named `aws_dynamodb_table.table`.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  iam_role_name = module.k8s_iam_role.name

  # Deployment specific environment variables
  environment_variables = {
    DYNAMODB_TABLE = aws_dynamodb_table.table.name
  }
}
```

### Override Working directory

Override your containers working directory to `/opt/app` (defaults to `/`).

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  working_dir = "/opt/app"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Disable Service/Ingress

If your application isn't exposing an API and does not require an HTTPS endpoint, you can disable the `Service` and `Ingress` resources.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  service_enabled = "false"
  ingress_enabled = "false"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Custom Service Port and Ingress Host/Path

The following example specifies a custom service port of `7000` (default is `8080`), and overrides the `ingress_host` and `ingress_path`. Please note that the `ingress_host` only defines the prefix of your hostname, and `.<ingress_host_dns_zone>` will be appended to the end to form the full hostname.

This ingress host/path override example is useful if you wish to:

- Include `<component>` in your hostname, rather that just `<system>` and `<environment>`
- Use root `/` as your ingress path, since your component name is included in your hostname.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  service_port = "7000"
  ingress_host = var.system}-${var.component}-${var.environment
  ingress_path = "/"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Disable Datadog/Prometheus metrics collection

By default, annotations will be added to your pod(s) to enable metrics collection from both Prometheus and Datadog. The following example disables metrics collection.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  prometheus_metrics_enabled = "false"
  datadog_metrics_enabled    = "false"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Enabling Horizontal Pod Autoscaling (simple)

The following example will create a Horizontal Pod Autoscaling (HPA) resource for your deployment, with the default values of min `2` replicas, max `12` replicas, with scaling triggered if the CPU usage percentage across all pods exceeds 75%.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  autoscaling_enabled = "true"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Enabling Horizontal Pod Autoscaling (advanced)

The following example will create a Horizontal Pod Autoscaling (HPA) resource for your your deployment, with custom values for min/max replicas and CPU target percentage.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  autoscaling_enabled               = "true"
  autoscaling_min_replicas          = "1"
  autoscaling_max_replicas          = "6"
  autoscaling_cpu_target_percentage = 50

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Enabling Vertical Pod Autoscaling

Vertical Pod Autoscaling (VPA) aims to calculate the optimum CPU and Memory for a given pod. Its `autoscaling_vpa_update_mode` can be set to `Auto` for the pod to be restarted with recommended requests values or to `Off` (default in k8s-standard-app) for just viewing the recommendations. Currently, VPA is experimental and, should be used with caution. 

You can't use both HPA and VPA for a deployment. The default is `hpa` and you can change to VPA with `autoscaling_mode` variable. The following example will create a VPA resource for your deployment, with the `autoscaling_vpa_update_mode` `Off`. Once a VPA resource created, you can view the recommended values at Datadog.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  autoscaling_enabled = "true"
  autoscaling_mode    = "vpa"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Mount Secrets/ConfigMaps as volumes

The following example assumes that you have defined Kubernetes ConfigMap and Secret resources in your Terraform named `kubernetes_secret.conf_directory` and `kubernetes_secret.secrets_directory`. For each entry in the ConfigMap/Secret, a file will be mounted under the specified directory with the key as the filename and value as the contents.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }

  # Mount files defined in "kubernetes_secret.secrets_directory" to directory "/opt/app/secrets"
  secret_volume_mounts = [
    {
      secretName      = kubernetes_secret.secrets_directory.metadata[0].name
      resourceVersion = kubernetes_secret.secrets_directory.metadata[0].resource_version
      mountPath       = "/opt/app/secrets"
    },
  ]

  # Mount files defined in "kubernetes_secret.conf_directory" to directory "/opt/app/conf"
  config_map_volume_mounts = [
    {
      configMapName   = kubernetes_config_map.conf_directory.metadata[0].name
      resourceVersion = kubernetes_config_map.conf_directory.metadata[0].resource_version
      mountPath       = "/opt/app/conf"
    },
  ]

}
```

### Customise healthcheck configuration

- Override your health check path to `/ping` (default is `/healthcheck`)
- Decrease initial delay to 5s (default is 60s).
  - This is handy if your app starts quickly (E.g. python api instead of java)
  - This will result in your deployment step succeeding faster
- Increase healthcheck timeout to 4s (default is 2s)
- Decrease healthcheck frequency to every 30s (default is 10s)

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  healthcheck_path      = "/ping"
  initial_delay_seconds = "5"
  timeout_seconds       = "4"
  period_seconds        = "30"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Specify a kubernetes service account

This example assumes that you have defined a `kubernetes_service_account` resource in your Terraform named `kubernetes_service_account.service_account`, and have defined associated RBAC Roles and RoleBindings to allow access to specific kubernetes resources via the kubernetes API.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  service_account_name = kubernetes_service_account.service_account.metadata.0.name

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}
```

### Custom pod annotations / labels

If you need to define custom pod annotations or labels for any reason, you can do so as follows.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }

  # Custom pod annotations
  custom_pod_annotations = {
    "my.custom.annotation" = "custom_annotation_value"
  }

  # Custom pod labels
  custom_pod_labels = {
    "my_custom_label" = "custom_label_value"
  }
}
```

### Custom helm values (overrides)

This is the most powerful parameter of the module, as it allows you to override any part of the raw Helm values yaml with any arbitrary value.  This is useful if your deployment requires advanced custom config, not exposed by other parameters/variables. Any values you define in this yaml will override all previously defined values, even those derived from other parameters passed to this module.

For a complete list of available helm chart values, view the contents of `./charts/k8s-standard-app/values.yaml` under this directory.

The following example does the following:

- Override the Image pullPolicy to `Always` (defaults to `IfNotPresent`)
- Sets the container command used to launch your container, overriding the value defined in your `Dockerfile`.
- Provides an entirely custom list of ingress hostnames, overriding the computed standard value.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }

  custom_helm_values = <<VALUES
deployment:
  image:
    pullPolicy: Always
  command:
  - /bin/bash
  - -c
  - 'echo "Hello World!"'

ingress:
  hosts:
    - 'custom-hostname-1.example.com'
    - 'custom-hostname-2.example.com'

VALUES
}
```


The following example provisions a network load balancer with ACM SSL certificate

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  custom_helm_values = <<VALUES
service:
  enabled: true
  type: LoadBalancer
  name: ${var.system}-${var.component}-${var.environment}
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-internal: "true"
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: data.aws_acm_certificate.example.arn
  port:
    name: http
    externalPort: 443
VALUES
}
```

### Deploy to Fargate with IAM for Service Accounts (disabling kube2iam support)

This example demonstrates deploying an app to Fargate using an IAM role configured for "IAM for Service Accounts".
It also demonstrates how to disable kube2iam based role support, which isn't strictly required.
Both kube2iam role support and IAM for service accounts can be enabled at the same time.

```hcl
module "app" {
  source = "git::https://github.com/reubit/terraform-modules.git//k8s-standard-app"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Deployment specific configuration
  fargate_enabled                   = "true"
  iam_role_name                     = module.k8s_iam_role.name
  iam_role_service_accounts_enabled = "true"
  iam_role_kube2iam_enabled         = "false"

  # Deployment specific environment variables
  environment_variables = {
    # Set environment variable inside your container/pod called `MY_ENVIRONMENT_VARIABLE`
    MY_ENVIRONMENT_VARIABLE = var.my_variable
  }
}

module "k8s_iam_role" {
  source = "git::https://github.com/reubit/terraform-modules.git//aws-iam-role-k8s"

  # Common variables provided by the pipeline (aws context, project metadata, environment, image tag, etc)
  common_variables = local.common_variables

  # Enable support for IAM for Service Accounts
  assume_role_policy_ec2_enabled        = "false"
  assume_role_policy_kube2iam_enabled   = "false"
  assume_role_policy_iam_for_sa_enabled = "true"
}

```
