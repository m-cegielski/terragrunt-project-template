locals {
  region       = "eu-west-1"
  account_name = regex("[a-z\\-\\_]+/[a-z\\-\\_]+$", path_relative_to_include())
}

dependency "root" {
  config_path = "${dirname(find_in_parent_folders())}/root-setup"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region              = "${local.region}"
  allowed_account_ids = ["${dependency.root.outputs.organization_all_accounts[local.account_name].id}"]

  assume_role {
    role_arn     = "arn:aws:iam::${dependency.root.outputs.organization_all_accounts[local.account_name].id}:role/OrganizationAccountAccessRole"
    session_name = "provider"
  }

  default_tags {
    tags = {
      account = "${replace(local.account_name, "/", "-")}"
    }
  }
}
EOF
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../modules/account-setup"
}
