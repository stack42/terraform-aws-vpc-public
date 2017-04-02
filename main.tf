
data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support = "${var.enable_dns_support}"

  tags {
      Name        = "${var.name}"
      terraform = "true"
      }

}

resource "aws_subnet" "network" {
  count             = "${var.az_count}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id            = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true

  tags {
      Name        = "${var.name}"
      terraform = "true"
      }
}

resource "aws_internet_gateway" "network" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
      Name        = "${var.name}"
      terraform = "true"
      }
}

resource "aws_route_table" "network" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.network.id}"
  }

  tags {
      Name        = "${var.name}"
      terraform = "true"
      }
}

resource "aws_route_table_association" "network" {
  count          = "${var.az_count}"
  subnet_id      = "${element(aws_subnet.network.*.id, count.index)}"
  route_table_id = "${aws_route_table.network.id}"
}
