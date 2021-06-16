# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE MULTIPLE IAM USERS AT ONCE
# This example shows how to create multiple users at once by passing a list
# of desired usernames to the module. We also attach some default IAM Policies
# to the created users.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# ------------------------------------------------------------------------------
# CREATE THE IAM USERS AND ATTACH DEFAULT IAM POLICIES
# ------------------------------------------------------------------------------


module "iam-users" {
  source = "./mod_users"

  names = [
    "user.one",
  ]

  policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/job-function/Billing",
  ]
}
