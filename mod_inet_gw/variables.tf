variable "vpc_id" {
  type        = string
  description = "(Required) The VPC ID to create in. "
  default     = ""
}


##------------------------------
##Attributes Reference
##------------------------------

variable "inet_gw_id" {
  type = string
}

variable "inet_gw_arn" {
  type = string
}
