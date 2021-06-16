
resource "aws_lb_listener" "main_lb_listener" {

  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  ##ssl_policy        = var.ssl_policy
  ##certificate_arn   = var.certificate_arn

  default_action {
    type             = var.default_action_type
    target_group_arn = var.target_group_arn
  }

}

output "lb_listener_id" {
  value = aws_lb_listener.main_lb_listener.id
}
output "lb_listener_arn" {
  value = aws_lb_listener.main_lb_listener.arn
}
