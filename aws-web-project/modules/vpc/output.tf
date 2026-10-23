output "vpc_id" {
  description = "the id for vpc"
  value       =  aws_vpc.main.id
}
output "vpc_cidr" {
  description = "cidr range for vpc"
  value       = aws_vpc.main.id
}
output "public_subnet_id" {
  description = "this subnet range for public"
  value       = aws_subnet.public[0].id
}
output "private_subnet_id" {
  description = "this subnet range for private"
  value       = aws_subnet.private[0].id
}
output "ig_id" {
  description = "this is for internetgateway"
  value       = aws_internet_gateway.igw.id
}
output "public_rt" {
  description = "route value for public"
  value       = aws_route_table.public.id
}
