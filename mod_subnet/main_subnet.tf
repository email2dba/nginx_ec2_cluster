

resource "aws_subnet" "main_subnet" {
  cidr_block        = var.subnet_cidr_block
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zone
  #availability_zone_id = var.availability_zone_id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "main_vpc"
  }
}

output "subnet_id" {
  value = aws_subnet.main_subnet.id
}

output "subnet_arn" {
  value = aws_subnet.main_subnet.arn
}
