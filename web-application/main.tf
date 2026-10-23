resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "web-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_public

  tags = {
    Name = var.subnet_public
  }
}
resource "aws_subnet" "web-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_private

  tags = {
    Name = var.subnet_private
  }
}
resource "aws_internet_gateway" "web-internetgateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.ig_name
  }
}
resource "aws_route_table" "web-public-route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web-internetgateway.id
  }

  tags = {
    Name = var.route_table_public
  }
}
resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.web-public.id
  route_table_id = aws_route_table.web-public-route.id
}
resource "aws_route_table" "web-private-route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.route_table_private
  }
}
resource "aws_route_table_association" "private-rt" {
  subnet_id      = aws_subnet.web-private.id
  route_table_id = aws_route_table.web-private-route.id
}
resource "aws_security_group" "web_security_group" {
  vpc_id = aws_vpc.main.id
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.51.43.239/32"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow outbound internet traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.security_group
  }
}
resource "tls_private_key" "ec2_jeevitha_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "ec2_key" {
  key_name   = "web-app-key-jeevitha"
  public_key = tls_private_key.ec2_jeevitha_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.ec2_jeevitha_key.private_key_pem
  filename        = "${path.module}/web-app-key-jeevitha.pem"
  file_permission = "0400"
}

resource "aws_instance" "instance_name" {
  ami                         = var.amiid
  instance_type               = var.instancetype
  subnet_id                   = aws_subnet.web-public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key.key_name


  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  
  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name        = var.instance_name
    environment = var.environment
  }
}
resource "aws_s3_bucket" "web-bucket" {
  bucket = "web-application-2026-123"

  tags = {
    Name = var.s3_bucket
  }
}
resource "aws_iam_policy" "ec2_s3_policy" {
  name = "ec2-web-bucket-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeRouteTables",
          "ec2:DescribeVolumes",
          "ec2:DescribeImages",
          "ec2:DescribeTags",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]

        Resource = [
          "*"
        ]
      }
    ]
  })
}
