resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.subnet_cidr_public)
  cidr_block              = var.subnet_cidr_public[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = var.subnet_name_public
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.subnet_cidr_private)
  cidr_block        = var.subnet_cidr_private[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name=var.subnet_name_private
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.ig_name
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.route_table_public_rt
  }
}
resource "aws_route_table_association" "public" {
  count = length(var.subnet_cidr_public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
