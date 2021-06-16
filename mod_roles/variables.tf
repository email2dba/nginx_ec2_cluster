# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ------------------------------------------------------------------------------

variable "names" {
  type        = set(string)
  description = "(Required) name. Role name."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------
variable "path" {
  type        = string
  description = "(Optional) Path in which to create the user. Default is \"/\"."
  default     = "/"
}

variable "myassume_role_policystr" {
  type        = string
  description = "json file formated string."
  default     = <<EOF
  {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                   "Service": "ec2.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
  }
EOF
}


variable "my_attach_policy" {
  type        = string
  description = "json file formated string."
  default     = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ec2:Describe*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
}
EOF
}

variable "permissions_boundary" {
  type        = string
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the user."
  default     = null
}

variable "description" {
  type        = string
  description = "(Optional) The description of the role."
  default     = "role created by terraform"
}

variable "force_detach_policies" {
  type        = bool
  description = "(Optional) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. Default is false."
  default     = false
}


variable "max_session_duration" {
  type        = number
  description = "(Optional) The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  default     = 3600
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of tags for the IAM user."
  default     = {}
}

variable "policy_assume_role_statements" {
  type        = any
  description = "(Optional) List of IAM policy statements to attach to the User as an inline policy."
  default     = []
}

variable "policy_statements" {
  type        = any
  description = "(Optional) List of IAM policy statements to attach to the User as an inline policy."
  default     = []
}


variable "policy_arns" {
  type        = set(string)
  description = "(Optional) Set of IAM custom or managed policies ARNs to attach to the User."
  default     = []
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------
variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is true."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is []."
  default     = []
}
