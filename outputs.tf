output "public_subnets" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "vpc_id" {
  value = "${module.aws_vpc.vpc.id}"
}

output "cidr_block" {
  value = "${var.cidr_block}"
}
