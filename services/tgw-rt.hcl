dependency "transit_gateway" {
  config_path = "${dirname(find_in_parent_folders())}/main/services/transit-gateway/tgw"
}

dependency "firewall" {
  config_path = "${dirname(find_in_parent_folders())}/main/services/firewall"
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../modules/transit-gateway-route-table"
}

inputs = {
  transit_gateway_id            = dependency.transit_gateway.outputs.ec2_transit_gateway_id
  transit_gateway_attachment_id = dependency.attachment.outputs.id

  create_egress_route    = true
  egress_tgw_attachement = dependency.firewall.outputs.tgw_attachment_id

}
