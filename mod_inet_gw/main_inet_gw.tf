

resource "aws_internet_gateway" "main_gw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "main_vpc"
  }
}

output "inet_gw_id" {
  value = aws_internet_gateway.main_gw.id
}

output "inet_gw_arn" {
  value = aws_internet_gateway.main_gw.arn
}


