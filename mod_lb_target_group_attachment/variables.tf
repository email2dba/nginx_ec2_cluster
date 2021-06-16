
#-----------------------------------------------
# lb_target_group variables
#-----------------------------------------------

variable "target_group_arn" {
  type        = string
  description = "(Required)"
  default     = null
}

variable "target_id" {
  type        = string
  description = "(Required)"
  default     = null
}

variable "port" {
  type        = string
  description = "(optional)"
  default     = "80"
}

variable "availability_zone" {
  type        = string
  description = "optional "
  default     = null
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

variable "lb_target_group_attachment_id" {
  type = string
}
