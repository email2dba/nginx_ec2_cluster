
resource "aws_lb_target_group" "main_lb_target_group" {

  name        = var.name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type


  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
  }


  tags = {
    Name = "main_vpc"
  }

}

output "lb_target_group_id" {
  value = aws_lb_target_group.main_lb_target_group.id
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.main_lb_target_group.arn
}

