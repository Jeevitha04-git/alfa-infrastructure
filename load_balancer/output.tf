output "vpc_id" {
  description = "this id for vpc"
  value       = aws_vpc.main.id
}
output "vpc_cidr" {
  description = "cidr rannge for vpc"
  value       = aws_vpc.main.id
}
output "public_subnet_id" {
  description = "subnet id for  public"
  value       = aws_subnet.public[0].id
}
output "private_subnet_id" {
  description = "subnet id for private"
  value       = aws_subnet.private[0].id
}
output "ig_id" {
  description = "internetgateway to allow the public routes"
  value       = aws_internet_gateway.igw.id
}
output "public_route" {
  description = "route table for public"
  value       = aws_route_table.public.id
}
# security group

output "security_group_id" {
  description = "id for security group"
  value       = aws_security_group.load_sg.id
}
output "security_group_name" {
  description = "name for security group"
  value       = aws_security_group.load_sg.name
}
# ec2 instance

output "instance_id" {
  description = "creating instance id "
  value       = aws_instance.instance_name[*].id
}
output "public_ip" {
  description = "creating ip for public instance"
  value       = aws_instance.instance_name[*].public_ip
}
output "private_ip" {
  description = "creating ip for private instance"
  value       = aws_instance.instance_name[*].private_ip
}
output "instance_name" {
  description = "name for ec2 instance"
  value       = aws_instance.instance_name[*].tags
}
# load balancer

output "load_balancer" {
  description = "load balancer dns name"
  value       = aws_lb.load-alb.dns_name
}
output "load_balancer_arn" {
  description = "arn for load balancer"
  value       = aws_lb.load-alb.arn
}