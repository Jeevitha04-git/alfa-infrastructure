output "instance_id" {
    description  = "instance id for ec2 instance"
    value        = aws_instance.instance_name.id
}
output "public_ip" {
    description = "public ip for ec2 instance"
    value       = aws_instance.instance_name.public_ip
}
output "private_ip" {
    description = "private ip ec2 instance"
    value       = aws_instance.instance_name.private_ip
}

output "instance_name" {
  description = "name for ec2 instance"
  value       = aws_instance.instance_name.tags
}
