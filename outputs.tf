output "public_subnets" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "cidr_block" {
  value = "${var.cidr_block}"
}

# This boilerplate is needed to expose the vpc ID to terraform remote state.
#https://www.terraform.io/docs/providers/terraform/d/remote_state.html
output "id" {
  value = "${aws_vpc.vpc.id}"
}
output "vpc_id" {
  value = "${module.vpc.id}"
