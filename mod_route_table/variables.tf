variable "vpc_id" {
  type        = string
  description = "(Required) The VPC ID to create in. "
  default     = ""
}

variable "destination" {
  type        = list(string)
  description = "(Optional) List of destination cidr."
  default     = []
}

variable "target" {
  type        = list(string)
  description = "(Optional) List of targets."
  default     = []
}

variable "route_statements" {
  type        = any
  description = "(Optional) List of route destination."
  default     = []
}
##------------------------------
##Attributes Reference
##------------------------------

variable "route_table_id" {
  type = string
}
