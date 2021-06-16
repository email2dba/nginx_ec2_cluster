
resource "aws_lb" "main_appl_lb" {

  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection


  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_on
  }

  tags = {
    Name = "main_vpc"
  }

}

output "appl_lb_id" {
  value = aws_lb.main_appl_lb.id
}
output "appl_lb_arn" {
  value = aws_lb.main_appl_lb.arn
}
