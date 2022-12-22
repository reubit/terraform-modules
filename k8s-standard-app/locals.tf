locals {
  aws_region                 = var.aws_region != "" ? var.aws_region : lookup(var.common_variables, "aws_region", "eu-west-1")
  aws_account_id             = var.aws_account_id != "" ? var.aws_account_id : var.common_variables["aws_account_id"]
  aws_account_name           = var.aws_account_name != "" ? var.aws_account_name : var.common_variables["aws_account_name"]
  k8s_cluster_name           = var.k8s_cluster_name != "" ? var.k8s_cluster_name : lookup(var.common_variables, "k8s_cluster_name", "eks-${local.aws_account_name}")
  k8s_namespace              = var.k8s_namespace != "" ? var.k8s_namespace : lookup(var.common_variables, "k8s_namespace", "${var.app_team}-${var.app_static_environment}")
  app_org                    = var.app_org != "" ? var.app_realm : var.common_variables["app_org"]
  app_realm                  = var.app_realm != "" ? var.app_realm : var.common_variables["app_realm"]
  app_account                = var.app_account != "" ? var.app_account : var.common_variables["app_account"]
  app_aws_domain             = var.app_aws_domain != "" ? var.app_aws_domain : var.common_variables["app_aws_domain"]
  app_owner_domain           = var.app_owner_domain != "" ? var.app_owner_domain : lookup(var.common_variables, "app_owner_domain", var.app_aws_domain)
  app_environment            = var.app_environment != "" ? var.app_environment : var.common_variables["app_environment"]
  app_static_environment     = var.app_static_environment != "" ? var.app_static_environment : var.common_variables["app_static_environment"]
  app_team                   = var.app_team != "" ? var.app_team : var.common_variables["app_team"]
  app_product                = var.app_product != "" ? var.app_product : lookup(var.common_variables, "app_product", "default")
  app_system                 = var.app_system != "" ? var.app_system : var.common_variables["app_system"]
  app_component              = var.app_component != "" ? var.app_component : var.common_variables["app_component"]
  app_instance               = var.app_instance != "" ? var.app_instance : lookup(var.common_variables, "app_instance", "default")
  docker_image_repo          = var.docker_image_repo != "" ? var.docker_image_repo : var.common_variables["docker_image_repo"]
  docker_image_tag           = var.docker_image_tag != "" ? var.docker_image_tag : var.common_variables["docker_image_tag"]
  ingress_path               = var.ingress_path != "" ? var.ingress_path : (var.common_variables["ingress_path"] != "" ? var.common_variables["ingress_path"] : "/${local.app_component}/")
  ingress_host               = var.ingress_host != "" ? var.ingress_host : (var.common_variables["ingress_host"] != "" ? var.common_variables["ingress_host"] : "${local.app_product}-${local.app_system}-${local.app_environment}")
  ingress_dns_zone           = var.ingress_dns_zone != "" ? var.ingress_dns_zone : var.common_variables["ingress_dns_zone"]
  gitlab_project_id          = var.gitlab_project_id != "" ? var.gitlab_project_id : var.common_variables["gitlab_project_id"]
  gitlab_project_url         = var.gitlab_project_url != "" ? var.gitlab_project_url : var.common_variables["gitlab_project_url"]
  gitlab_commit_ref_name     = var.gitlab_commit_ref_name != "" ? var.gitlab_commit_ref_name : var.common_variables["gitlab_commit_ref_name"]
  gitlab_commit_sha          = var.gitlab_commit_sha != "" ? var.gitlab_commit_sha : var.common_variables["gitlab_commit_sha"]
  gitlab_pipeline_id         = var.gitlab_pipeline_id != "" ? var.gitlab_pipeline_id : var.common_variables["gitlab_pipeline_id"]
  gitlab_pipeline_url        = var.gitlab_pipeline_url != "" ? var.gitlab_pipeline_url : var.common_variables["gitlab_pipeline_url"]
  gitlab_pipeline_user_login = var.gitlab_pipeline_user_login != "" ? var.gitlab_pipeline_user_login : var.common_variables["gitlab_pipeline_user_login"]
  gitlab_pipeline_user_name  = var.gitlab_pipeline_user_name != "" ? var.gitlab_pipeline_user_name : var.common_variables["gitlab_pipeline_user_name"]
  gitlab_pipeline_user_email = var.gitlab_pipeline_user_email != "" ? var.gitlab_pipeline_user_email : var.common_variables["gitlab_pipeline_user_email"]

  is_non_prod = local.app_environment != "prod" ? "true" : "false"

  common_variables = {
    "aws_region"                 = local.aws_region
    "aws_account_id"             = local.aws_account_id
    "aws_account_name"           = local.aws_account_name
    "k8s_cluster_name"           = local.k8s_cluster_name
    "k8s_namespace"              = local.k8s_namespace
    "app_org"                    = local.app_org
    "app_realm"                  = local.app_realm
    "app_account"                = local.app_account
    "app_aws_domain"             = local.app_aws_domain
    "app_owner_domain"           = local.app_owner_domain
    "app_environment"            = local.app_environment
    "app_static_environment"     = local.app_static_environment
    "app_team"                   = local.app_team
    "app_product"                = local.app_product
    "app_system"                 = local.app_system
    "app_component"              = local.app_component
    "app_instance"               = local.app_instance
    "docker_image_repo"          = local.docker_image_repo
    "docker_image_tag"           = local.docker_image_tag
    "ingress_path"               = local.ingress_path
    "ingress_host"               = local.ingress_host
    "ingress_dns_zone"           = local.ingress_dns_zone
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

  otel_resource_attributes = [
    "k8s_cluster_name=${local.k8s_cluster_name}",
    "k8s_namespace=${local.k8s_namespace}",
    "aws_account_id=${local.aws_account_id}",
    "aws_account_name=${local.aws_account_name}",
    "app_realm=${local.app_realm}",
    "app_account=${local.app_account}",
    "app_static_environment=${local.app_static_environment}",
    "app_environment=${local.app_environment}",
    "app_team=${local.app_team}",
    "app_product=${local.app_product}",
    "app_system=${local.app_system}",
    "app_component=${local.app_component}",
    "app_instance=${local.app_instance}",
    "version=${local.docker_image_tag}"
  ]

  default_environment_variables = {
    # Project metadata environment variables
    APP                    = module.resource_names.k8s_resource
    APP_STATIC_ENVIRONMENT = local.app_static_environment
    APP_ENVIRONMENT        = local.app_environment
    APP_TEAM               = local.app_team
    APP_PRODUCT            = local.app_product
    APP_SYSTEM             = local.app_system
    APP_COMPONENT          = local.app_component
    APP_INSTANCE           = local.app_instance
    APP_REALM              = local.app_realm
    APP_ACCOUNT            = local.app_account
    APP_AWS_DOMAIN         = local.app_aws_domain
    APP_DOCKER_IMAGE_REPO  = local.docker_image_repo
    APP_DOCKER_IMAGE_TAG   = local.docker_image_tag
    APP_DOCKER_IMAGE       = "${local.docker_image_repo}:${local.docker_image_tag}"
    APP_VERSION            = local.docker_image_tag
    APP_INGRESS_DNS_ZONE   = local.ingress_dns_zone
    APP_INGRESS_HOST       = local.ingress_host
    APP_INGRESS_PATH       = local.ingress_path
    APP_ENDPOINT           = "https://${local.ingress_host}.${local.ingress_dns_zone}${local.ingress_path}"

    # Kubernetes & Docker environment variables
    K8S_NAMESPACE     = local.k8s_namespace
    K8S_CLUSTER_NAME  = local.k8s_cluster_name
    K8S_RESOURCE_NAME = module.resource_names.k8s_resource

    # OpenTelemetry environment variables
    OTEL_SERVICE_NAME               = module.resource_names.k8s_resource
    OTEL_EXPORTER_OTLP_ENDPOINT     = "${var.otel_exporter_otlp_endpoint}:4317"
    OTEL_RESOURCE_ATTRIBUTES        = join(",", local.otel_resource_attributes)
    OTEL_PYTHON_FLASK_EXCLUDED_URLS = var.otel_python_flask_excluded_urls

    # AWS SDK environment variables
    AWS_METADATA_SERVICE_TIMEOUT      = "10"
    AWS_METADATA_SERVICE_NUM_ATTEMPTS = "10"
    AWS_REGION                        = local.aws_region
    AWS_DEFAULT_REGION                = local.aws_region
    AWS_STS_REGIONAL_ENDPOINTS        = "regional"

    # Datadog library env vars
    DD_ENV     = local.app_environment
    DD_SERVICE = module.resource_names.k8s_resource
    DD_VERSION = local.docker_image_tag
  }

  environment_variables = merge(local.default_environment_variables, var.environment_variables)

  default_deployment_labels = {
    "tags.datadoghq.com/env"     = local.app_environment
    "tags.datadoghq.com/service" = module.resource_names.k8s_resource
    "tags.datadoghq.com/version" = local.docker_image_tag
  }

  # Merge final map of deployment labels
  deployment_labels_json = jsonencode(merge(local.default_deployment_labels, var.custom_deployment_labels))

  default_deployment_annotations = {
    "${local.app_owner_domain}/gitlab-project-id"          = lookup(var.common_variables, "gitlab_project_id", "")
    "${local.app_owner_domain}/gitlab-project-url"         = lookup(var.common_variables, "gitlab_project_url", "")
    "${local.app_owner_domain}/gitlab-commit-ref-name"     = lookup(var.common_variables, "gitlab_commit_ref_name", "")
    "${local.app_owner_domain}/gitlab-commit-sha"          = lookup(var.common_variables, "gitlab_commit_sha", "")
    "${local.app_owner_domain}/gitlab-pipeline-id"         = lookup(var.common_variables, "gitlab_pipeline_id", "")
    "${local.app_owner_domain}/gitlab-pipeline-url"        = lookup(var.common_variables, "gitlab_pipeline_url", "")
    "${local.app_owner_domain}/gitlab-pipeline-user-login" = lookup(var.common_variables, "gitlab_pipeline_user_login", "")
    "${local.app_owner_domain}/gitlab-pipeline-user-name"  = lookup(var.common_variables, "gitlab_pipeline_user_name", "")
    "${local.app_owner_domain}/gitlab-pipeline-user-email" = lookup(var.common_variables, "gitlab_pipeline_user_email", "")
  }

  # Merge final map of deployment annotations
  deployment_annotations_json = jsonencode(merge(local.default_deployment_annotations, var.custom_deployment_annotations))

  iam_role_name   = var.iam_role_name != "" ? var.iam_role_name : (var.iam_role_create ? module.aws-iam-role-k8s[0].name : "")
  prometheus_port = var.prometheus_metrics_port != "" ? var.prometheus_metrics_port : var.service_port

  default_pod_annotations = {
    "prometheus.io/scrape"                         = var.prometheus_metrics_enabled
    "prometheus.io/port"                           = local.prometheus_port
    "prometheus.io/path"                           = var.prometheus_metrics_path
    "iam.amazonaws.com/role"                       = var.iam_role_kube2iam_enabled ? local.iam_role_name : ""
    "${local.app_owner_domain}/gitlab-project-id"  = lookup(var.common_variables, "gitlab_project_id", "")
    "${local.app_owner_domain}/gitlab-project-url" = lookup(var.common_variables, "gitlab_project_url", "")
  }

  # Pod annotations for sending prometheus metrics to datadog
  default_datadog_metrics_namespace = local.app_instance == "default" ? "${local.app_product}.${local.app_system}.${local.app_component}" : "${local.app_product}.${local.app_system}.${local.app_component}.${local.app_instance}"
  datadog_metrics_namespace         = var.datadog_metrics_namespace != "" ? var.datadog_metrics_namespace : local.default_datadog_metrics_namespace
  datadog_pod_annotations = {
    "ad.datadoghq.com/k8s-standard-app.check_names"  = "[\"prometheus\"]"
    "ad.datadoghq.com/k8s-standard-app.init_configs" = "[{}]"
    "ad.datadoghq.com/k8s-standard-app.instances"    = "[{\"prometheus_url\": \"http://%%host%%:${local.prometheus_port}${var.prometheus_metrics_path}\",\"namespace\": \"${local.datadog_metrics_namespace}\",\"metrics\": ${jsonencode(var.datadog_metrics_list)}}]"
  }

  # Merge final map of pod annotations
  pod_annotations_json = var.datadog_metrics_enabled ? jsonencode(
    merge(
      local.default_pod_annotations,
      local.datadog_pod_annotations,
      var.custom_pod_annotations,
    ),
    ) : jsonencode(
    merge(local.default_pod_annotations, var.custom_pod_annotations),
  )

  # Define pod lables
  infrastructure_label = var.fargate_enabled ? "fargate" : "standard"
  default_pod_labels = {
    "infrastructure"             = local.infrastructure_label
    "tags.datadoghq.com/env"     = local.app_environment
    "tags.datadoghq.com/service" = module.resource_names.k8s_resource
    "tags.datadoghq.com/version" = local.docker_image_tag
  }
  pod_labels_json = jsonencode(merge(local.default_pod_labels, var.custom_pod_labels))

  # Service account details

  default_service_account_name         = var.service_account_create ? module.resource_names.k8s_resource : "null"
  service_account_name                 = var.service_account_name != "" ? var.service_account_name : local.default_service_account_name
  service_account_iam_annotation_value = "arn:aws:iam::${local.aws_account_id}:role/${local.iam_role_name}"
  service_account_annotations          = merge(local.default_service_account_annotations, var.service_account_custom_annotations)
  service_account_labels               = merge(local.default_service_account_labels, var.service_account_custom_labels)
  default_service_account_annotations = {
    "eks.amazonaws.com/role-arn" = var.iam_role_service_accounts_enabled ? local.service_account_iam_annotation_value : ""
  }
  default_service_account_labels = {
    "app_environment" = local.app_environment
    "app_team"        = local.app_team
    "app_product"     = local.app_product
    "app_system"      = local.app_system
    "app_component"   = local.app_component
    "app_instance"    = local.app_instance
  }

  healthcheck_http_yaml = <<YAML
    httpGet:
      path: "${var.healthcheck_path}"
      port: ${var.service_port}
      scheme: "HTTP"
YAML

  healthcheck_exec_yaml = <<YAML
    exec:
      command:
      - /bin/sh
      - -c
      - "${var.healthcheck_command}"
YAML

  healthcheck_yaml = var.healthcheck_command != "" ? local.healthcheck_exec_yaml : local.healthcheck_http_yaml

  ingress_rewrite_target_yaml = <<YAML
    nginx.ingress.kubernetes.io/configuration-snippet: |
      rewrite "(?i)${local.ingress_path}(.*)" /$1 break;
YAML


  helm_values = <<VALUES
fullnameOverride: ${module.resource_names.k8s_resource}

app:
  team: ${local.app_team}
  product: ${local.app_product}
  environment: ${local.app_environment}
  system: ${local.app_system}
  component: ${local.app_component}
  instance: ${local.app_instance}

deployment:
  command: ${jsonencode(var.container_command)}
  args: ${jsonencode(var.container_args)}
  annotations: ${local.deployment_annotations_json}
  labels: ${local.deployment_labels_json}
  replicaCount: ${var.replica_count}
  rollingUpdate:
    maxSurge: ${var.max_surge}
    maxUnavailable: ${var.max_unavailable}
  image:
    pullPolicy: IfNotPresent
  environmentVariables: ${jsonencode(local.environment_variables)}
  configMapVolumeMounts: ${jsonencode(var.config_map_volume_mounts)}
  secretVolumeMounts: ${jsonencode(var.secret_volume_mounts)}
  workingDir: ${var.working_dir}
  podAnnotations: ${local.pod_annotations_json}
  podLabels: ${local.pod_labels_json}
  resources:
    requests:
      cpu: ${var.cpu_request}
      memory: ${var.memory_request}
    limits:
      cpu: ${var.cpu_limit}
      memory: ${var.memory_limit}
  livenessProbeEnabled: ${var.liveness_probe_enabled}
  livenessProbe:
${var.liveness_probe_enabled ? local.healthcheck_yaml : ""}
    initialDelaySeconds: ${var.initial_delay_seconds}
    timeoutSeconds: ${var.timeout_seconds}
    periodSeconds: ${var.period_seconds}
  readinessProbeEnabled: ${var.readiness_probe_enabled}
  readinessProbe:
${var.readiness_probe_enabled ? local.healthcheck_yaml : ""}
    initialDelaySeconds: ${var.initial_delay_seconds}
    timeoutSeconds: ${var.timeout_seconds}
    periodSeconds: ${var.period_seconds}
  serviceAccountName: ${local.service_account_name}
  podAntiAffinity:
    preferred:
      node:
        enabled: ${var.pod_antiaffinity_preferred_node_enabled}
        weight: ${var.pod_antiaffinity_preferred_node_weight}
      zone:
        enabled: ${var.pod_antiaffinity_preferred_zone_enabled}
        weight: ${var.pod_antiaffinity_preferred_zone_weight}
    required:
      node:
        enabled: ${var.pod_antiaffinity_required_node_enabled}
  securityContext: ${var.security_context_json}

autoscaling:
  enabled: ${var.autoscaling_enabled}
  mode: ${var.autoscaling_mode}
  hpa:
    minReplicas: ${var.autoscaling_min_replicas}
    maxReplicas: ${var.autoscaling_max_replicas}
    targetCPUUtilizationPercentage: ${var.autoscaling_cpu_target_percentage}
    behavior:
      scaleDown:
        stabilizationWindowSeconds: ${var.autoscaling_scale_down_stabilization_window}
        policies:
        - type: Percent
          value: 100
          periodSeconds: 15
      scaleUp:
        stabilizationWindowSeconds: ${var.autoscaling_scale_up_stabilization_window}
        policies:
        - type: Percent
          value: 100
          periodSeconds: 15
        - type: Pods
          value: 4
          periodSeconds: 15
        selectPolicy: Max
  vpa:
    updateMode: '${var.autoscaling_vpa_update_mode}'

service:
  enabled: ${var.service_enabled}
  type: ClusterIP
  port:
    name: http
    externalPort: ${var.service_port}
    internalPort: ${var.service_port}

ingress:
  enabled: ${var.ingress_enabled}
  hosts:
    - '${local.ingress_host}.${local.ingress_dns_zone}'
  path: '${local.ingress_path}'
  annotations:
    kubernetes.io/ingress.class: ${var.ingress_class}
    nginx.ingress.kubernetes.io/proxy-body-size: 32m
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "1"
    nginx.ingress.kubernetes.io/proxy-next-upstream: "error timeout http_500 http_502 http_503 http_504 non_idempotent"
    nginx.ingress.kubernetes.io/proxy-next-upstream-tries: "5"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "5"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "5"
${var.ingress_rewrite_target_enabled ? local.ingress_rewrite_target_yaml : ""}

podDisruptionBudget:
  enabled: ${var.pdb_enabled}
  spec:
    maxUnavailable: ${var.pdb_max_unavailable}

VALUES

}

