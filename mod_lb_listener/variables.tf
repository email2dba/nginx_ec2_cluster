
#-----------------------------------------------
# lb_target_group variables
#-----------------------------------------------
variable "load_balancer_arn" {
  type        = string
  description = "(Required)"
  default     = "main_lb"
}

variable "port" {
  type        = string
  description = "(Required)"
  default     = "80"
}

variable "protocol" {
  type        = string
  description = "(Required)"
  default     = "HTTPS"
}


variable "ssl_policy" {
  type        = string
  description = "(optional)"
  default     = "ELBSecurityPolicy-2016-08"
}



variable "certificate_arn" {
  type        = string
  description = "(optional)"
  default     = null
}

variable "target_group_arn" {
  type        = string
  description = "(optional)"
  default     = null
}

variable "default_action_type" {
  type        = string
  description = "(optional)"
  default     = "forward"
}

#variable "private_ips" {
#  type        = list(string)
#  description = "(Required)  . "
#  default = []
#}
#

##------------------------------
##Attributes Reference
##------------------------------

variable "lb_listener_id" {
  type = string
}

variable "lb_listener_arn" {
  type = string
}
