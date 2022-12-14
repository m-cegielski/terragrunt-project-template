module "user_roles" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"
  version = "~> 4.3"

  trusted_role_arns = [
    "arn:aws:iam::${var.sec_account_id}:root",
  ]

  create_admin_role       = true
  admin_role_name         = "ops"
  admin_role_requires_mfa = false

  create_readonly_role       = true
  readonly_role_name         = "readonly"
  readonly_role_requires_mfa = false
}

module "deploymnet_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"
  version = "~> 4.3"

  trusted_role_arns = [
    "arn:aws:iam::${var.deploy_account_id}:root",
    "arn:aws:iam::${var.sec_account_id}:root",
  ]

  create_admin_role       = true
  admin_role_name         = "deployment"
  admin_role_requires_mfa = false
}
