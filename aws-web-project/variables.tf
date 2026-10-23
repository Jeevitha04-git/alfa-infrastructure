variable "aws_region" {
  description = "the root region for aws"
  type        = string
}
variable "vpc_name" {
  description = "name for the project"
  type        = string
}
variable "vpc_cidr" {
  description = "the cidr range for vpc "
  type        = string
}
variable "availability_zone" {
  description = "availabity zone for vpc to run"
  type        = list(string)
}
variable "subnet_name_public" {
  description = "the subnets for the public"
  type        = string
}
variable "subnet_name_private" {
  description = "the subnet for private"
  type        = string
}
variable "subnet_cidr_public" {
  description = "the cidr range for public subnet"
  type        = list(string)
}
variable "subnet_cidr_private" {
  description = "the cidr range for private subnet"
  type        = list(string)
}
variable "ig_name" {
  description = "this internetgateway for public subnets"
  type        = string
}
variable "route_table_public_rt" {
  description = "this route table for public"
  type        = string
}
variable "environment" {
  description = "the enivronment for project"
  type        = string
}

# ec2
variable "instance_name" {
  description = "instance name for ec2"
  type        = string
}
variable "amiid" {
  description = "the template for ec2 instance"
  type        = string
}
variable "availabilityzone" {
  description = "availability zone for ec2 instance to run"
  type        = string
}
variable "instancetype" {
  description = "size for ec2 instance"
  type        = string
}
variable "key_name" {
  description = "key pair to access the ec2"
  type        = string
}
variable "subnet_public_id" {
  description = "subnet is for public in ec2"
  type        = string
}

# security_group
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR allowed for SSH"
  type        = string
}
