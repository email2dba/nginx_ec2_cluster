
#-----------------------------------------------
# lb_target_group variables
#-----------------------------------------------
variable "listener_arn" {
  type        = string
  description = "(Required)"
  default     = "main_lb"
}

variable "priority" {
  type        = string
  description = "(optional)"
  default     = null
}

variable "action_statements" {
  type        = any
  description = "(Required)"
  default     = []
}


variable "condition_statements1" {
  type        = any
  description = "(Required)"
  default     = []
}

variable "condition_statements2" {
  type        = any
  description = "(Required)"
  default     = []
}

variable "condition_statements3" {
  type        = any
  description = "(Required)"
  default     = []
}


variable "condition_statements4" {
  type        = any
  description = "(Required)"
  default     = []
}

##------------------------------
##Attributes Reference
##------------------------------

variable "lb_listener_rule_id" {
  type = string
}

variable "lb_listener_rule_arn" {
  type = string
}
