resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    "project" = var.project_name,
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "sn_backend" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, 2)
  availability_zone = "us-east-1a"

  tags = {
    "project" = var.project_name,
    Name = "${var.project_name}-backend-subnet"
  }
}

resource "aws_subnet" "sn_backend_az2" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, 4)
  availability_zone = "us-east-1b"

  tags = {
    "project" = var.project_name,
    Name = "${var.project_name}-backend-subnet-az2"
  }
}

resource "aws_subnet" "sn_frontend" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, 3)
  availability_zone = "us-east-1b"

  tags = {
    "project" = var.project_name,
    Name = "${var.project_name}-frontend-subnet"
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    "project" = var.project_name,
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "rt_backend" {
  subnet_id = aws_subnet.sn_backend.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_backend_az2" {
  subnet_id = aws_subnet.sn_backend_az2.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_frontend" {
  subnet_id = aws_subnet.sn_frontend.id
  route_table_id = aws_route_table.rt_private.id
}