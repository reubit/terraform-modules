resource "helm_release" "app-rabbitmq" {
  count = var.rabbitmq_enabled ? 1 : 0

  name      = "${module.resource_names.helm_release}-rabbitmq"
  chart     = "stable/rabbitmq"
  version   = "6.4.2"
  namespace = local.namespace

  values = [
    <<VALUES
fullnameOverride: ${local.rabbitmq_name}

rabbitmq:
  username: celery
  password: celery
  erlangCookie: celery

ingress:
  enabled: true
  hostName: ${local.ingress_host}
  path: /rabbitmq/
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /

resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi

replicas: 3

metrics:
  enabled: true

VALUES
    ,
  ]
}

