
#-----------------------------------------------
# lb_target_group variables
#-----------------------------------------------

variable "name" {
  type        = string
  description = "(Required)"
  default     = "main_lb"
}

variable "internal" {
  type        = bool
  description = "(Required)"
  default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "(optional)"
  default     = "application"
}

variable "security_groups" {
  type        = list(string)
  description = "optional "
  default     = []
}

variable "subnets" {
  type        = list(string)
  description = "optional "
  default     = []
}

variable "enable_deletion_protection" {
  type        = bool
  description = "(optional)"
  default     = true
}

variable "access_logs_bucket" {
  type        = string
  description = "(optional)"
  default     = null
}

variable "access_logs_prefix" {
  type        = string
  description = "(optional)"
  default     = "main_lb"
}

variable "access_logs_on" {
  type        = bool
  description = "(optional)"
  default     = false
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

variable "appl_lb_id" {
  type = string
}

variable "appl_lb_arn" {
  type = string
}
