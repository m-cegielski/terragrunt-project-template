module "user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 4.3"

  for_each = var.users

  name          = each.key
  pgp_key       = each.value.pgp_key
  force_destroy = true

  create_iam_access_key = false

  password_length         = local.password_length
  password_reset_required = false
}
