output "vpc_id" {
  description = "id for vpc"
  value       = module.vpc.vpc_id
}
output "vpc_cidr" {
  description = "cidr range dor vpc"
  value       = module.vpc.vpc_cidr
}
output "public_subnet_id" {
  description = "name for public subnet"
  value       = module.vpc.public_subnet_id
}
output "private_subnet_id" {
  description = "name for private subnet"
  value       = module.vpc.private_subnet_id
}
output "ig_id" {
  description = "internetgateway id "
  value       = module.vpc.ig_id
}
output "public_rt" {
  description = "public route table id"
  value       = module.vpc.public_rt
}

# ec2
output "instance_id" {
  description = "instance id for ec2"
  value       = module.ec2_instance.instance_id
}
output "public_ip" {
  description = "public ip address for ec2"
  value       = module.ec2_instance.public_ip
}
output "private_ip" {
  description = "private ip for ec2 instance"
  value       = module.ec2_instance.private_ip
}

# security_group
output "security_group_id" {
  description = "created security group id"
  value       = module.security_group.security_group_id
}
output "security_group_name" {
  description = "created by security group name"
  value       = module.security_group.security_group_name
}