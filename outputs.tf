output "public_subnets" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "cidr_block" {
  value = "${var.cidr_block}"
}


output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
