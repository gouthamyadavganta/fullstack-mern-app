variable "vpc_id" {
  description = "VPC ID where EKS will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
