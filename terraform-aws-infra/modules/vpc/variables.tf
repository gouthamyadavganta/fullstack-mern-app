variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "ssh_cidr" {
  description = "CIDR block to allow SSH from"
  type        = string
  default     = "variables.tf" 
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}
