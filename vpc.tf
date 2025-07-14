# ------------------------------
# VPC
# ------------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # DNSによる名前解決を有効化
  enable_dns_hostnames = true
  
  tags = {
    "Name" = "${local.project}-vpc"
  }
}

# ------------------------------
# IGW
# ------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    "Name" = "${local.project}-igw"
  }
}

# ------------------------------
# public subnet a
# ------------------------------
resource "aws_subnet" "public_subnet_a" {
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-northeast-1a"

  tags = {
    "Name" = "${local.project}-public-subnet-a"
  }
}

resource "aws_route_table" "public_subnet_a" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${local.project}-public-subnet-a"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_subnet_a.id
}

resource "aws_route" "public_subnet_a" {
  route_table_id = aws_route_table.public_subnet_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# ------------------------------
# public subnet c
# ------------------------------
resource "aws_subnet" "public_subnet_c" {
  cidr_block = "10.0.20.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-northeast-1c"

  tags = {
    "Name" = "${local.project}-public-subnet-c"
  }
}

resource "aws_route_table" "public_subnet_c" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${local.project}-public-subnet-c"
  }
}

resource "aws_route_table_association" "public_subnet_c" {
  subnet_id = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_subnet_c.id
}

resource "aws_route" "public_subnet_c" {
  route_table_id = aws_route_table.public_subnet_c.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# ------------------------------
# private subnet d
# ------------------------------
resource "aws_subnet" "private_subnet_d" {
  cidr_block = "10.0.30.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-northeast-1d"

  tags = {
    "Name" = "${local.project}-private-subnet-d"
  }
}

resource "aws_route_table" "private_subnet_d" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${local.project}-private-subnet-d"
  }
}

resource "aws_route_table_association" "private_subnet_d" {
  subnet_id = aws_subnet.private_subnet_d.id
  route_table_id = aws_route_table.private_subnet_d.id
}
