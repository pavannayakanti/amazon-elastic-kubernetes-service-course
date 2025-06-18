####################################################################
#
# Variables used. All have defaults
#
####################################################################

# KK Playground. Cluster must be called 'demo-eks'

variable "trainee_name" {
  description = "Name of the trainee to uniquely identify the EKS cluster"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "" # default to empty, dynamically created in main.tf
}

variable "cluster_role_name" {
  type        = string
  description = "Name of the cluster role"
  default     = "" # default to empty, dynamically created in main.tf
}

variable "node_role_name" {
  type        = string
  description = "Name of node role"
  default     = "" # default to empty, dynamically created in main.tf
}

variable "additional_policy_name" {
  type        = string
  description = "Name of IAM::Policy created for additional permissions"
  default     = "" # default to empty, dynamically created in main.tf
}

variable "node_group_desired_capacity" {
  type        = number
  description = "Desired capacity of Node Group ASG."
  default     = 3
}
variable "node_group_max_size" {
  type        = number
  description = "Maximum size of Node Group ASG. Set to at least 1 greater than node_group_desired_capacity."
  default     = 4
}

variable "node_group_min_size" {
  type        = number
  description = "Minimum size of Node Group ASG."
  default     = 1
}

