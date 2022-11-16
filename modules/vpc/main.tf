# VPC
resource "aws_vpc" "practice-vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = "true"

  tags = {
    "Name" = "practice-vpc"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "practice-ig" {
  vpc_id = aws_vpc.practice-vpc.id
}

# PUBLIC SUBNET 1
resource "aws_subnet" "subnet1" {
  cidr_block              = var.sub1-cidr
  vpc_id                  = aws_vpc.practice-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
}

# PUBLIC SUBNET 2
resource "aws_subnet" "subnet2" {
  cidr_block              = var.sub2-cidr
  vpc_id                  = aws_vpc.practice-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[1]
}

# ROUTE TABLE
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.practice-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practice-ig.id
  }
}

resource "aws_route_table_association" "route-igw" {
  gateway_id     = aws_internet_gateway.practice-ig.id
  route_table_id = aws_route_table.route_table1.id
}

resource "aws_route_table_association" "route-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table1.id
}

resource "aws_route_table_association" "route-subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table1.id
}