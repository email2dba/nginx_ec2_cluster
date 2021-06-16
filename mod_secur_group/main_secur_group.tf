

resource "aws_security_group" "main_secur_group" {
  vpc_id = var.vpc_id
  tags = {
    Name = "main_vpc"
  }

  dynamic "ingress" {
    for_each = var.ingress_statements
    content {
      cidr_blocks      = try(ingress.value.source, null)
      ipv6_cidr_blocks = try(ingress.value.ip6source, null)
      prefix_list_ids  = try(ingress.value.prefix_list_ids, null)
      from_port        = try(ingress.value.from_port, null)
      protocol         = try(ingress.value.protocol, null)
      security_groups  = try(ingress.value.security_groups, null)
      to_port          = try(ingress.value.to_port, null)
      description      = try(ingress.value.description, null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_statements
    content {
      cidr_blocks      = try(egress.value.destination, null)
      ipv6_cidr_blocks = try(egress.value.ip6destination, null)
      prefix_list_ids  = try(egress.value.prefix_list_ids, null)
      from_port        = try(egress.value.from_port, null)
      protocol         = try(egress.value.protocol, null)
      security_groups  = try(egress.value.security_groups, null)
      to_port          = try(egress.value.to_port, null)
      description      = try(egress.value.description, null)
    }
  }

}

output "secur_group_id" {
  value = aws_security_group.main_secur_group.id
}

output "secur_group_arn" {
  value = aws_security_group.main_secur_group.arn
}

#
