

resource "aws_route_table" "main_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "main_vpc"
  }

  #-----------
  #  count = "${length(var.destination)}"
  #  route {
  #      cidr_block = "${var.destination[count.index]}"
  #      gateway_id = "${var.target[count.index]}"
  #  }
  #-----------

  dynamic "route" {
    for_each = var.route_statements
    content {
      cidr_block = try(route.value.destination, null)
      gateway_id = try(route.value.target_gateway_id, null)
    }
  }

}

output "route_table_id" {
  value = aws_route_table.main_route_table.id
}

#
#egress_only_gateway_id - (Optional) Identifier of a VPC Egress Only Internet Gateway.
#gateway_id - (Optional) Identifier of a VPC internet gateway or a virtual private gateway.
#instance_id - (Optional) Identifier of an EC2 instance.
#nat_gateway_id - (Optional) Identifier of a VPC NAT gateway.
#local_gateway_id - (Optional) Identifier of a Outpost local gateway.
#network_interface_id - (Optional) Identifier of an EC2 network interface.
#transit_gateway_id - (Optional) Identifier of an EC2 Transit Gateway.
#vpc_endpoint_id - (Optional) Identifier of a VPC Endpoint.
#vpc_peering_connection_id - (Optional) Identifier of a VPC peering
