##------------------------------
# Require arguments
##------------------------------

variable "subnet_id" {
  type        = string
  description = "(Required) ami"
  default     = ""
}

##------------------------------
# Optional arguments
##------------------------------

variable "description" {
  type        = string
  description = "(Optional) t2.micro  free instance_type"
  default     = " "
}

variable "private_ips" {
  type        = list(string)
  description = "(Optional)  . "
  default     = []
}

variable "security_groups" {
  type        = list(string)
  description = "(Optional)  . "
  default     = []
}

##------------------------------
##Attributes Reference
##------------------------------

variable "net_interface_id" {
  type = string
}

variable "net_interface_mac_address" {
  type = string
}


/*
subnet_id - (Required) Subnet ID to create the ENI in.
description - (Optional) A description for the network interface.
private_ips - (Optional) List of private IPs to assign to the ENI.
private_ips_count - (Optional) Number of secondary private IPs to assign to the ENI. The total number of private IPs will be 1 + private_ips_count, as a primary private IP will be assiged to an ENI by default.
ipv6_addresses - (Optional) One or more specific IPv6 addresses from the IPv6 CIDR block range of your subnet. You can't use this option if you're specifying ipv6_address_count.
ipv6_address_count - (Optional) The number of IPv6 addresses to assign to a network interface. You can't use this option if specifying specific ipv6_addresses. If your subnet has the AssignIpv6AddressOnCreation attribute set to true, you can specify 0 to override this setting.
security_groups - (Optional) List of security group IDs to assign to the ENI.
attachment - (Optional) Block to define the attachment of the ENI. Documented below.
source_dest_check - (Optional) Whether to enable source destination checking for the ENI. Default true.
tags - (Optional) A map of tags to assign to the resource.
*/
