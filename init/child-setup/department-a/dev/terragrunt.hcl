include "backend" {
  path = find_in_parent_folders()
}

include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

inputs = {
  sec_account_id     = dependency.root.outputs.organization_all_accounts["main/security"].id
  deploy_account_id  = dependency.root.outputs.organization_all_accounts["main/services"].id
  member_account_ids = [for k, v in dependency.root.outputs.organization_all_accounts : v.id]
  account_alias      = "c-mi-dep-a-dev"
}
