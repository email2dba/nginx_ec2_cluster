
resource "aws_lb_listener" "main_lb_listener4redirect" {

  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type = var.default_action_type
    redirect {
      port        = var.redirect_port
      protocol    = var.rediect_protocol
      status_code = var.status_code
    }

  }

  tags = {
    Name = "main_vpc"
  }

}

output "lb_listener_id" {
  value = aws_lb_listener.main_lb_listener4redirect.id
}
output "lb_listener_arn" {
  value = aws_lb_listener.main_lb_listener4redirect.arn
}
