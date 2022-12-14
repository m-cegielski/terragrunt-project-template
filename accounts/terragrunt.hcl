locals {
  base_region       = "eu-west-1"
  current_path_dirs = split("/", path_relative_to_include())
  account_name      = join("/", slice(local.current_path_dirs, 0, 2))
}

dependency "root" {
  config_path = "${dirname(find_in_parent_folders())}/../init/root-setup"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region              = "${local.base_region}"
  allowed_account_ids = ["${dependency.root.outputs.organization_all_accounts[local.account_name].id}"]

  assume_role {
    role_arn     = "arn:aws:iam::${dependency.root.outputs.organization_all_accounts[local.account_name].id}:role/deployment"
    session_name = "provider"
  }

  default_tags {
    tags = {
      account_name = "${local.account_name}"
    }
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "c-mi-main-shared-tf-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.base_region
    dynamodb_table = "terraform-locks"
    role_arn       = "arn:aws:iam::${dependency.root.outputs.organization_all_accounts["main/services"].id}:role/deployment"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  name         = replace(path_relative_to_include(), "/", "-")
  account_name = local.account_name
}
