
#-----------------------------------------------
# lb_target_group variables
#-----------------------------------------------

variable "name" {
  type        = string
  description = "(Required)"
  default     = "main-lb-target-group"
}


variable "port" {
  type        = string
  description = "(Required)"
  default     = "80"
}

variable "protocol" {
  type        = string
  description = " "
  default     = "HTTP"
}


variable "vpc_id" {
  type        = string
  description = " "
  default     = null
}

variable "target_type" {
  type        = string
  description = " instance or ip or lambda."
  default     = "instance"
}

variable "health_check_statements" {
  type        = any
  description = "(Optional, Maximum of 1) A Health Check block. Health Check blocks are documented below."
  default     = []
}
#-----------------------------------------------
# health_check details
#-----------------------------------------------

variable "healthy_threshold" {
  type        = number
  description = " "
  default     = 3
}

variable "unhealthy_threshold" {
  type        = number
  description = " "
  default     = 10
}

variable "health_check_timeout" {
  type        = number
  description = " "
  default     = 5
}

variable "health_check_interval" {
  type        = number
  description = " "
  default     = 10
}


variable "health_check_path" {
  type        = string
  description = " "
  default     = "/"
}

variable "health_check_port" {
  type        = string
  description = " "
  default     = "80"
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

variable "lb_target_group_id" {
  type = string
}

variable "lb_target_group_arn" {
  type = string
}
