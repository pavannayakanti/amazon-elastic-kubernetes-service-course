locals {
  cluster_name           = var.cluster_name != "" ? var.cluster_name : "demo-eks-${var.trainee_name}"
  cluster_role_name      = var.cluster_role_name != "" ? var.cluster_role_name : "eksClusterRole-${var.trainee_name}"
  node_role_name         = var.node_role_name != "" ? var.node_role_name : "eksWorkerNodeRole-${var.trainee_name}"
  additional_policy_name = var.additional_policy_name != "" ? var.additional_policy_name : "eksPolicy-${var.trainee_name}"
}
