variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_group_name" {
  description = "security group name"
  type        = string
}

variable "ssh_cidr" {
  description = "cidr allowed for SSH"
  type        = string
}

variable "environment" {
  description = "environment name"
  type        = string
}