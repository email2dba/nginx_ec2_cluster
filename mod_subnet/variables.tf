


# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ------------------------------------------------------------------------------

variable "subnet_cidr_block" {
  type        = string
  description = "(Required) The CIDR block for the subnet. "
  default     = "192.168.1.0/24"
}

variable "vpc_id" {
  type        = string
  description = "(Required) The CIDR block for the subnet. "
  default     = ""
}


# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------


variable "availability_zone" {
  type        = string
  description = "(Optional) The AZ for the subnet. "
  default     = "us-east-1a"
}

variable "availability_zone_id" {
  type        = string
  description = "(Optional) The AZ ID of the subnet."
  default     = ""
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = " (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  default     = false
}

##------------------------------
##Attributes Reference
##------------------------------

variable "subnet_id" {
  type = string
}

variable "subnet_arn" {
  type = string
}

#-------------------------------------------
## For developers reference
#map_customer_owned_ip_on_launch - (Optional) Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true. Default is false.
#customer_owned_ipv4_pool - (Optional) The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured.
#ipv6_cidr_block - (Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length.
#outpost_arn - (Optional) The Amazon Resource Name (ARN) of the Outpost.
#assign_ipv6_address_on_creation - (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false
#tags - (Optional) A map of tags to assign to the resource.
#-------------------------------------------
