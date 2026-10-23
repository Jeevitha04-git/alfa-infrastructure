variable "aws_region" {
  description = "region for aws to run"
  type        = string
}
variable "vpc_cidr" {
  description = "cidr range for vpc"
  type        = string
}
variable "availability_zone" {
  description = "availability zone for vpc"
  type        = list(string)
}
variable "public_subnet_cidr" {
  description = "public subnet range "
  type        = list(string)
}
variable "private_subnet_cidr" {
  description = "private subnet range"
  type        = list(string)
}
variable "vpc_name" {
  description = "name for vpc "
  type        = string
}
variable "public_subnet_name" {
  description = "name for public subnet"
  type        = string
}
variable "private_subnet_name" {
  description = "name for private subnet"
  type        = string
}
variable "internetgateway" {
  description = "creating internetgateway"
  type        = string
}
variable "public_route_table" {
  description = "name for route table"
  type        = string
}
variable "environment" {
  description = "environment for load balancer"
  type        = string
}

# security group

variable "security_group_name" {
  description = "security group name"
  type        = string
}

variable "ssh_cidr" {
  description = "cidr allowed for SSH"
  type        = string
}

# ec2 instance

variable "instance_name" {
  description = "this is for instance name"
  type        = string
}
variable "instancetype" {
  description = "instance type for ec2"
  type        = string
}
variable "amiid" {
  description = "template for ec2"
  type        = string
}
variable "availabilityzone" {
  description = "availability zone for ec2"
  type        = string
}
variable "key_name" {
  description = "key pair to access the ec2"
  type        = string
}
variable "root_volume_size" {
  description = "size of instance box"
  type        = string
}

# loadd balancer

# Load Balancer variables

variable "load_balancer_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "alb_security_group_name" {
  description = "Security group name for the load balancer"
  type        = string
}

