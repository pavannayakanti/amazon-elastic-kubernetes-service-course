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

####################################################################
#
# IAM Role Modules
#
####################################################################

####################################################################
#
# Creates the EKS Cluster control plane
#
####################################################################


####################################################################
#
# Outputs
#
####################################################################

output "NodeInstanceRole" {
  value = aws_iam_role.node_instance_role.arn
}

output "NodeSecurityGroup" {
  value = aws_security_group.node_security_group.id
}

output "NodeAutoScalingGroup" {
  value = aws_cloudformation_stack.autoscaling_group.outputs["NodeAutoScalingGroup"]
}
