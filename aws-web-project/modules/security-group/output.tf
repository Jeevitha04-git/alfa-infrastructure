output "security_group_id" {
  description = "id for security group"
  value       = aws_security_group.web_sg.id
}
output "security_group_name" {
  description = "name for security group"
  value       = aws_security_group.web_sg.name
}