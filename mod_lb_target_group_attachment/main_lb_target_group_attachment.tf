
resource "aws_lb_target_group_attachment" "main_lb_target_group_attachment" {

  target_group_arn = var.target_group_arn
  target_id        = var.target_id
  port             = var.port


}

output "lb_target_group_attachment_id" {
  value = aws_lb_target_group_attachment.main_lb_target_group_attachment.id
}

