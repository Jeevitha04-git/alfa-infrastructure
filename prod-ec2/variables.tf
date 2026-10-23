variable "aws_region" {
  description = "for the selection of the region in ec2"
  type        = string
}

variable "instance_name" {
  description = "this is a name of ec2 instance"
  type        = string
}

variable "amiid" {
  description = "this is ami id is used for the ec2 instance"
  type        = string
}

variable "instancetype" {
  description = "this is used to choose the instance type for ec2"
  type        = string
}

variable "availabilityzone" {
  description = "this is used for selecting the subnet for ec2 instance"
  type        = string
}

variable "environment_name" {
  description = "this is dev environment"
  type        = string
}

variable "root_volume_size" {
  description = "this is used to allocate the  volume size of ec2 instance"
  type        = number
}

variable "ec2-sg" {
  description = "security group for ec2"
  type        = string
}

variable "terraform_key" {
  description = "creating the key pair for ec2"
  type        = string
}