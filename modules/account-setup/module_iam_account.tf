module "iam_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-account"
  version = "~> 4.7"

  account_alias = var.account_alias

  minimum_password_length = local.password_length
}
