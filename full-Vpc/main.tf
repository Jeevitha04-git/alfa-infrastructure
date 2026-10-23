resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "prod-public" {
  vpc_id     = aws_vpc.name.id
  cidr_block = var.subnet_cidr_public

  tags = {
    Name = var.subnet_name
  }

}
resource "aws_internet_gateway" "prod-IG" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = var.ig_name
  }
}
resource "aws_route_table" "prod-public-rt" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-IG.id
  }

  tags = {
    Name = var.route_table_name
  }
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.prod-public.id
  route_table_id = aws_route_table.prod-public-rt.id
}
resource "aws_subnet" "prod-private-subnet" {
  vpc_id     = aws_vpc.name.id
  cidr_block = var.subnet_cidr_private

  tags = {
    Name = var.subnet_name_private
  }
}
resource "aws_route_table" "prod-private-rt" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-prod.id
  }

  tags = {
    Name = var.route_table_name_private
  }
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.prod-private-subnet.id
  route_table_id = aws_route_table.prod-private-rt.id

}
resource "aws_eip" "nat" {
  domain ="vpc"
}
resource "aws_nat_gateway" "nat-prod" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.prod-public.id

  tags = {
    Name=var.NAT_gateway
  }
}

resource "aws_security_group" "prod-sg" {
  vpc_id = aws_vpc.name.id
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
  ami                         = var.amiid
  instance_type               = var.instancetype
  availability_zone           = var.availabilityzone
  subnet_id                   = aws_subnet.prod-public.id
  associate_public_ip_address = true
  key_name                    = "prod-key"

  vpc_security_group_ids = [aws_security_group.prod-sg.id]

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name = var.instance_name
    environment = var.environment
  }
}