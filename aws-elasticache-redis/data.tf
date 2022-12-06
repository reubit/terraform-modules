data "aws_eks_cluster" "cluster" {
  count = var.enabled ? 1 : 0

  name = local.k8s_cluster_name
}

data "aws_subnets" "subnets" {
  count = var.enabled ? 1 : 0

  filter {
    name   = "vpc-id"
    values = data.aws_eks_cluster.cluster[0].vpc_config[0].vpc_id
  }

  filter {
    name   = "tag:Name"
    values = ["*${var.k8s_cluster_name}*Private"]
  }
}


