variable "name_override" {
  default = ""
}

variable "path" {
  default = "/"
}

variable "k8s_service_name" {
  default = ""
}

variable "node_role_cfn_export_name" {
  default = "cp-core-eks-nodegroup-default-NodeInstanceRole"
}

variable "assume_role_policy_ec2_enabled" {
  default = "false"
}

variable "assume_role_policy_kube2iam_enabled" {
  default = "false"
}

variable "assume_role_policy_iam_for_sa_enabled" {
  default = "true"
}
