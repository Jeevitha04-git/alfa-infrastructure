variable "aws_region" {
  description = "aws region"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for vpc"
  type        = string
}
variable "subnet_cidr_public" {
  description = "cidr block for subnets"
  type        = list(string)
}
variable "subnet_cidr_private" {
  description = "cidr block for subnets"
  type        = list(string)
}
variable "vpc_name" {
  description = "name of vpc "
  type        = string
}
variable "subnet_name_public" {
  description = "name for subnets"
  type        = string
}
variable "subnet_name_private" {
  description = "name for subnets"
  type        = string
}
variable "ig_name" {
  description = "name for internetgateway"
  type        = string
}
variable "availability_zone" {
  description = "availability zone for subnets"
  type = list(string)
}
variable "route_table_public_rt" {
  description = "name for route table"
  type        = string
}
variable "environment" {
  description = "enivronment name for project"
  type = string
}