variable "cidr_block" {}

variable "az_count" {}

variable "name" {}

variable "region" {}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "enable_dns_support" {
  default = "true"
}
