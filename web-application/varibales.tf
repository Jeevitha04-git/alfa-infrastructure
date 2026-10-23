variable "aws_region" {
  description = "region for aws"
  type        = string
}
variable "vpc_cidr" {
  description = "cidr range for vpc"
  type        = string
}
variable "subnet_cidr_public" {
  description = "cidr block for subnets"
  type        = string
}
variable "subnet_cidr_private" {
  description = "cidr block for private subnet"
  type        = string
}
variable "vpc_name" {
  description = "name of vpc "
  type        = string
}
variable "subnet_public" {
  description = "name for public subnet"
  type        = string
}
variable "subnet_private" {
  description = "name for private subnet"
  type        = string
}
variable "ig_name" {
  description = "name for internetgateway"
  type        = string
}
variable "route_table_public" {
  description = "name for public route table"
  type        = string
}
variable "route_table_private" {
  description = "name for private route table"
  type        = string
}
variable "security_group" {
  description = "creating the security group for ec2"
  type        = string
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
variable "root_volume_size" {
  description = "size of instance box"
  type        = string
}
variable "s3_bucket" {
  description = "used to store the file"
  type        = string
}