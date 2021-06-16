
resource "aws_lb_listener_rule" "main_lb_listener_rule" {

  listener_arn = var.listener_arn
  priority     = var.priority

  dynamic "action" {
    for_each = var.action_statements
    content {
      type             = try(action.value.type, null)
      target_group_arn = try(action.value.target_group_arn, null)
    }
  }


  dynamic "condition" {
    for_each = var.condition_statements1
    content {
      dynamic "path_pattern" {
        for_each = try(condition.value.path_pattern, [])
        content {
          values = path_pattern.value.values
        }
      }
      dynamic "host_header" {
        for_each = try(condition.value.host_header, [])
        content {
          values = host_header.value.values
        }
      }
    }
  }

  dynamic "condition" {
    for_each = var.condition_statements2
    content {
      dynamic "path_pattern" {
        for_each = try(condition.value.path_pattern, [])
        content {
          values = path_pattern.value.values
        }
      }
      dynamic "host_header" {
        for_each = try(condition.value.host_header, [])
        content {
          values = host_header.value.values
        }
      }
    }
  }



}

output "lb_listener_rule_id" {
  value = aws_lb_listener_rule.main_lb_listener_rule.id
}
output "lb_listener_rule_arn" {
  value = aws_lb_listener_rule.main_lb_listener_rule.arn
}
