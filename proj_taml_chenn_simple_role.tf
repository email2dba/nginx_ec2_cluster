# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE MULTIPLE IAM USERS AT ONCE
# This example shows how to create multiple users at once by passing a list
# of desired usernames to the module. We also attach some default IAM Policies
# to the created users.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# ------------------------------------------------------------------------------
# CREATE THE IAM USERS AND ATTACH DEFAULT IAM POLICIES
# ------------------------------------------------------------------------------


module "iam-roles" {
  source = "./mod_roles"

  names = ["role.one", ]


  policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/job-function/Billing",
  ]

  policy_assume_role_statements = [
    {
      effect = "Allow"
      sid    = ""
      actions = ["sts:AssumeRole",
      ]

      principals = [
        {
          service = "ec2.amazonaws.com"
        }
      ]
    }
  ]

  policy_statements = [
    {
      sid    = "AllowViewAccountInfo"
      effect = "Allow"

      actions = [
        "iam:GetAccountPasswordPolicy",
        "iam:GetAccountSummary",
        "iam:ListVirtualMFADevices"
      ]

      resources = ["*"]
    },
    {
      sid    = "AllowManageOwnPasswords"
      effect = "Allow"

      actions = [
        "iam:ChangePassword",
        "iam:GetUser"
      ]

      resources = [
        "arn:aws:iam::*:user/&{aws:username}"
      ]

    },
    {
      sid    = "AllowManageOwnAccessKeys"
      effect = "Allow"
      actions = [
        "iam:CreateAccessKey",
        "iam:DeleteAccessKey",
        "iam:ListAccessKeys",
        "iam:UpdateAccessKey"
      ],
      resources = [
        "arn:aws:iam::*:user/&{aws:username}"
      ]
    },
    {
      sid    = "AllowManageOwnVirtualMFADevice"
      effect = "Allow"
      actions = [
        "iam:CreateVirtualMFADevice",
        "iam:DeleteVirtualMFADevice"
      ]
      resources = [
        "arn:aws:iam::*:user/&{aws:username}"
      ]
    },
    {
      sid    = "AllowManageOwnUserMFA"
      effect = "Allow"
      actions = [
        "iam:DeactivateMFADevice",
        "iam:EnableMFADevice",
        "iam:ListMFADevices",
        "iam:ResyncMFADevice"
      ]
      resources = [
        "arn:aws:iam::*:user/&{aws:username}"
      ]
    },
    {
      sid    = "DenyAllExceptListedIfNoMFA"
      effect = "Deny"
      not_actions = [
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:GetUser",
        "iam:ListMFADevices",
        "iam:ListVirtualMFADevices",
        "iam:ResyncMFADevice",
        "sts:GetSessionToken",
      ]

      resources = ["*"],

      conditions = [
        {
          test     = "ConditionIfBoolExists"
          variable = "aws:MultiFactorAuthPresent"
          values   = ["false"]
        }
      ]
    }
  ]


  myassume_role_policystr = <<EOF
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

  my_attach_policy = <<EOF
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
