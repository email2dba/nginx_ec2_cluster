# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ------------------------------------------------------------------------------

variable "vpc_cidr_block" {
  type        = string
  description = "(Required) The CIDR block for the VPC. "
  default     = "192.168.0.0/16"
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------
variable "instance_tenancy" {
  type        = string
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr. "
  default     = "default"
}

variable "enable_dns_support" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  default     = false
}

variable "enable_classiclink" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false."
  default     = false
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false."
  default     = false
}

##------------------------------
##Attributes Reference
##------------------------------

variable "vpc_id" {
  type = string
}

variable "vpc_arn" {
  type        = string
  description = "Amazon Resource Name (ARN) of VPC"
}
