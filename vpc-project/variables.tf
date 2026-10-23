variable "aws_region" {
  description = "aws region"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for vpc"
  type        = string
}
variable "subnet_cidr" {
  description = "cidr block for subnets"
  type        = string
}
variable "vpc_name" {
  description = "name of vpc "
  type        = string
}
variable "subnet_name" {
  description = "name for subnets"
  type        = string
}
variable "ig_name" {
  description = "name for internetgateway"
  type        = string
}
variable "route_table_name" {
  description = "name for route table"
  type        = string
}