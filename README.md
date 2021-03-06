Terraform AWS VPC Public
===========

A terraform module to provide a public only VPC in AWS.

This module is an example for a demo single-tier and public facing application.

Module Input Variables
----------------------

- `cidr_block`  = The CIDR block of the VPC
- `aws_region`  = AWS region where to run the VPC
- `az_count`    = Number of availability zones
- `name`        = variable name
- `environment` = variable environment

Usage
-----
```hcl
variable "name" {
  default = "demo"
}
variable "environment" {
  default = "demo"
}
variable "aws_region" {
  default = "us-east-2"
}
provider "aws" {
    region = "${var.aws_region}"
}

module "demo_vpc" {
  source      = "github.com/stack42/terraform_aws_vpc_public/"
  cidr_block  = "10.0.0.0/16"
  az_count    = "3"
  name        = "${var.name}"
  environment = "${var.environment}"
}
```


Outputs
=======

- `vpc_id`     - The ID of the VPC
- `subnets`    - The IDs of the VPC subnets
- `cidr_block` - The CIDR block of the VPC
- `aws_region` - The AWS region where the VPC is running

Authors
=======

phillip@bailey.st
