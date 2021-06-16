
variable "vpc_id" {
  type        = string
  description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false"
  default     = ""
}

variable "secur_group_name" {
  type        = string
  description = "(Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name "
  default     = ""
}

variable "secur_group_name_prefix" {
  type        = string
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name"
  default     = ""
}

variable "secur_group_description" {
  type        = string
  description = "(Optional, Forces new resource) The security group description. Defaults to Managed by Terraform. Cannot be null. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags"
  default     = ""
}

variable "target" {
  type        = list(string)
  description = "(Optional) List of targets."
  default     = []
}

variable "ingress_statements" {
  type        = any
  description = "(Optional) Can be specified multiple times for each ingress rule. Each ingress block supports fields documented below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

variable "egress_statements" {
  type        = any
  description = "(Optional, VPC only) Can be specified multiple times for each egress rule. Each egress block supports fields documented below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false"
  default     = false
}

##------------------------------
##Attributes Reference
##------------------------------

variable "secur_group_id" {
  type = string
}

variable "secur_group_arn" {
  type = string
}
