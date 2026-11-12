variable "aws_region" {
    description = "this is region of ec2 instance"
    type = string
}
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
variable "environment" {
  description = "environment for ec2"
  type        = string
}
variable "subnet_public_id" {
  description = "id for public subnet for instance"
  type        =string
}

