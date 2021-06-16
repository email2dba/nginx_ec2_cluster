

resource "aws_vpc" "main_vpc" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_classiclink               = var.enable_classiclink
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags = {
    Name = "main_vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "vpc_arn" {
  value = aws_vpc.main_vpc.arn
}
