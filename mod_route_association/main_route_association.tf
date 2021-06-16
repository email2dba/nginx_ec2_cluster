
resource "aws_route_table_association" "main_route_association" {
  route_table_id = var.route_table_id
  gateway_id     = var.gateway_id
  subnet_id      = var.subnet_id
}

output "route_association_id" {
  value = aws_route_table_association.main_route_association.id
}
