# ------------------------------------------------------------------------------
# AWS IAM USER
# This module creates a single or multiple AWS IAM USER
# You can attach an inline policy and/or custom/managed policies through their ARNs
# You can add the user to a list of groups (use module_depends_on to depend on group resources)
# ------------------------------------------------------------------------------


locals {
  policy_enabled = var.module_enabled && length(var.policy_statements) > 0
}


data "aws_iam_policy_document" "assume_role_policy" {
  count = local.policy_enabled ? 1 : 0

  dynamic "statement" {
    for_each = var.policy_statements

    content {
      sid           = try(statement.value.sid, null)
      effect        = try(statement.value.effect, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

data "aws_iam_policy_document" "custom_policy" {
  count = local.policy_enabled ? 1 : 0

  dynamic "statement" {
    for_each = var.policy_statements

    content {
      sid           = try(statement.value.sid, null)
      effect        = try(statement.value.effect, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_role" "role" {
  for_each = var.module_enabled ? var.names : []
  name     = each.key
  #  path                  = var.path
  #  permissions_boundary  = var.permissions_boundary
  #  force_detach_policies = var.force_detach_policies
  #  max_session_duration  = var.max_session_duration
  ##  tags                  = var.tags
  assume_role_policy = var.myassume_role_policystr
  ##data.aws_iam_policy_document.assume_role_policy[0].json
  depends_on = [var.module_depends_on]
}




resource "aws_iam_policy" "policy" {
  for_each = local.policy_enabled ? aws_iam_role.role : {}
  policy   = var.my_attach_policy
  name     = each.value.name

  depends_on = [var.module_depends_on]
}

locals {
  policy_arns = tolist(setproduct(var.names, var.policy_arns))
}


# Attach custom or managed policies
resource "aws_iam_role_policy_attachment" "mod-role-policy-attach" {
  count      = var.module_enabled ? length(local.policy_arns) : 0
  role       = local.policy_arns[count.index][0]
  policy_arn = local.policy_arns[count.index][1]

  depends_on = [
    var.module_depends_on,
    aws_iam_role.role,
  ]
}


#resource "aws_iam_role_policy_attachment" "modrole-customr-policy-attach" {
#for_each = local.policy_enabled ? aws_iam_role.role : {}
#   policy_arn  =  each.value.name
#   role =   each.value.name
#}

# Create Profile
resource "aws_iam_instance_profile" "role_profile" {
  for_each = local.policy_enabled ? aws_iam_role.role : {}
  name     = each.value.name
  role     = each.value.name
}
