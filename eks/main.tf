####################################################################
#
# Main Terraform config for EKS cluster with trainee-specific names
#
####################################################################

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Owner"                                      = var.trainee_name
      "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    }
  }
}

# Locals for dynamic naming based on trainee_name
locals {
  cluster_name           = var.cluster_name != "" ? var.cluster_name : "demo-eks-${var.trainee_name}"
  cluster_role_name      = var.cluster_role_name != "" ? var.cluster_role_name : "eksClusterRole-${var.trainee_name}"
  node_role_name         = var.node_role_name != "" ? var.node_role_name : "eksWorkerNodeRole-${var.trainee_name}"
  additional_policy_name = var.additional_policy_name != "" ? var.additional_policy_name : "eksPolicy-${var.trainee_name}"
}

module "use_eksClusterRole" {
  count  = var.use_predefined_role ? 1 : 0
  source = "./modules/use-service-role"

  cluster_role_name = local.cluster_role_name
}

module "create_eksClusterRole" {
  count  = var.use_predefined_role ? 0 : 1
  source = "./modules/create-service-role"

  cluster_role_name = local.cluster_role_name
  additional_policy_arns = [
    aws_iam_policy.loadbalancer_policy.arn
  ]
}

####################################################################
#
# Creates the EKS Cluster control plane
#
####################################################################

resource "aws_eks_cluster" "demo_eks" {
  name     = local.cluster_name
  role_arn = var.use_predefined_role ? module.use_eksClusterRole[0].eksClusterRole_arn : module.create_eksClusterRole[0].eksClusterRole_arn

  vpc_config {
    subnet_ids = [
      data.aws_subnets.public.ids[0],
      data.aws_subnets.public.ids[1],
      data.aws_subnets.public.ids[2]
    ]
  }

  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
}

# Outputs
output "NodeInstanceRole" {
  value = aws_iam_role.node_instance_role.arn
}

output "NodeSecurityGroup" {
  value = aws_security_group.node_security_group.id
}

output "NodeAutoScalingGroup" {
  value = aws_cloudformation_stack.autoscaling_group.outputs["NodeAutoScalingGroup"]
}
