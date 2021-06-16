variable "route_table_id" {
  type        = string
  description = "(Required) The VPC ID to create in. "
  default     = ""
}

variable "gateway_id" {
  type        = string
  description = "(Optional) The gateway ID to create an association. Conflicts with subnet_id."
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "(Optional) The subnet ID to create an association. Conflicts with gateway_id."
  default     = null
}

##------------------------------
##Attributes Reference
##------------------------------

variable "route_association_id" {
  type = string
}
