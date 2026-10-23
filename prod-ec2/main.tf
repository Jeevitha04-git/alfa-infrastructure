resource "aws_security_group" "ec2-sg" {
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "instance_name" {
  ami               = var.amiid
  instance_type     = var.instancetype
  availability_zone = var.availabilityzone
  key_name          = "terraform-key"

  security_groups = [aws_security_group.ec2-sg.name]

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name        = var.instance_name
    environment = var.environment_name
  }

}
