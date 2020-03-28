resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name        = var.name
    Tier        = "Public"
    terraform   = "true"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 2, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name        = var.name
    Tier        = "Public"
    terraform   = "true"
  }
}

resource "aws_internet_gateway" "public_internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = var.name
    Tier        = "Public"
    terraform   = "true"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  count  = var.az_count

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_internet_gateway.id
  }

  tags = {
    Name        = var.name
    terraform   = "true"
    Tier        = "Public"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_table.*.id, count.index)
}
