resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnet_cidr)
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = var.private_subnet_name
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internetgateway
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table
  }
}
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
# security group
resource "aws_security_group" "load_sg" {
  name   = var.security_group_name
  vpc_id = aws_vpc.main.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.ssh_cidr]
  }
  ingress {
    description     = "HTTP for alb"
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.alb_sg.id]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# ec2 instance
resource "tls_private_key" "ec2_load_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "ec2-key" {
  key_name   = "lb-project"
  public_key = tls_private_key.ec2_load_key.public_key_openssh
}
resource "local_file" "private_key" {
  content         = tls_private_key.ec2_load_key.private_key_pem
  filename        = "${path.module}/lb-project.pem"
  file_permission = 0400
}
resource "aws_instance" "instance_name" {
  count                       = length(var.public_subnet_cidr)
  ami                         = var.amiid
  instance_type               = var.instancetype
  subnet_id                   = aws_subnet.public[count.index].id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2-key.key_name

  vpc_security_group_ids = [aws_security_group.load_sg.id]
  root_block_device {
    volume_size = var.root_volume_size
  }
  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}
# load balancer-alb
resource "aws_security_group" "alb_sg" {
  name   = var.alb_security_group_name
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Http form internet"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.alb_security_group_name
  }
}
resource "aws_lb" "load-alb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]
  subnets         = [aws_subnet.public[0].id, aws_subnet.public[1].id]

  tags = {
    Name = var.load_balancer_name
  }
}
# target
resource "aws_lb_target_group" "alb_tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    unhealthy_threshold = 2
    healthy_threshold   = 2
    interval            = 30
  }

  tags = {
    Name = var.target_group_name
  }
}
resource "aws_lb_target_group_attachment" "ec2-attach" {
  count            = length(aws_instance.instance_name)
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.instance_name[count.index].id
  port             = 80
}
resource "aws_lb_listener" "port-http" {
  load_balancer_arn = aws_lb.load-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}