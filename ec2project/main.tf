provider "aws" {
    region ="ap-south-1"
}
data "aws_vpc" "default" {
    default = true
}
data "aws_subnet" "default" {
    availability_zone ="ap-south-1a"
    default_for_az = true
}
resource "aws_key_pair" "my_key"{
    key_name = "Terraform-key"
    public_key = file("Terraform-key.pub")
}
resource "aws_security_group" "my-security-group" {
    name = "terraform-sg"
    vpc_id = data.aws_vpc.default.id
ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "jeevitha_ec2" {
    ami = "ami-090d68841c2a28756"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    subnet_id = data.aws_subnet.default.id
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [
        aws_security_group.my-security-group.id
    ]
    associate_public_ip_address = true

  tags = {
    Name = "Terraform-EC2"
  }
}