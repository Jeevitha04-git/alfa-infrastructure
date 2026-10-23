resource "tls_private_key" "ec2-module-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}
resource "aws_key_pair" "ec2-key" {
  key_name = "module_key"
  public_key = tls_private_key.ec2-module-key.public_key_openssh
}
resource "local_file" "private-key" {
  content         = tls_private_key.ec2-module-key.private_key_openssh
  filename        = "${path.module}/module_key.pem"
  file_permission = "0400"
}
resource "aws_instance" "instance_name" {
  ami                         = var.amiid
  instance_type               = var.instancetype
  subnet_id                   = var.subnet_public_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2-key.key_name
   
  tags = {
    Name       =var.instance_name
    environment=var.environment
  }
}