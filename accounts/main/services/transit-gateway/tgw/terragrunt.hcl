include "root" {
  path = find_in_parent_folders()
}

include "service" {
  path = "${dirname(find_in_parent_folders())}/../services/transit-gateway.hcl"
}

inputs = {

  description = "Main Transit Gateway shared with an organization"

  enable_auto_accept_shared_attachments  = true
  enable_default_route_table_association = false
  enable_default_route_table_propagation = true

  ram_allow_external_principals = true
  ram_principals                = [for account in dependency.root.outputs.all_account_ids : account if account != dependency.root.outputs.organization_all_accounts["main/services"].id]

}
