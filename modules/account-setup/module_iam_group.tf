module "deployment_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version = "~> 4.3"

  count = length(keys(var.users)) > 0 ? 1 : 0

  name            = "deployment"
  assumable_roles = formatlist("arn:aws:iam::%s:role/deployment", var.member_account_ids)
  group_users     = compact([for user, attributes in var.users : contains(attributes.groups, "deployment") ? user : ""])
}

module "ops_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version = "~> 4.3"

  count = length(keys(var.users)) > 0 ? 1 : 0

  name            = "ops"
  assumable_roles = formatlist("arn:aws:iam::%s:role/*", var.member_account_ids)
  group_users     = compact([for user, attributes in var.users : contains(attributes.groups, "ops") ? user : ""])
}

module "readonly_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version = "~> 4.3"

  count = length(keys(var.users)) > 0 ? 1 : 0

  name            = "readonly"
  assumable_roles = formatlist("arn:aws:iam::%s:role/readonly", var.member_account_ids)
  group_users     = compact([for user, attributes in var.users : contains(attributes.groups, "readonly") ? user : ""])
}

module "mfa_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "4.8.0"

  count = length(keys(var.users)) > 0 ? 1 : 0

  name                              = "require_mfa"
  attach_iam_self_management_policy = false
  group_users                       = keys(var.users)
  custom_group_policies = [
    {
      name   = "require_mfa"
      policy = data.aws_iam_policy_document.mfa_requirement_policy.json
    }
  ]
}

resource "aws_iam_group_policy_attachment" "root_access_to_deployment" {
  count = length(keys(var.users)) > 0 ? 1 : 0

  group      = "deployment"
  policy_arn = aws_iam_policy.root_access[0].arn
}
