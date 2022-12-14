dependency "transit_gateway" {
  config_path = "${dirname(find_in_parent_folders())}/main/services/transit-gateway/tgw"
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../modules/network-firewall"
}

inputs = {
  transit_gateway_id     = dependency.transit_gateway.outputs.ec2_transit_gateway_id
  default_route_table_id = dependency.transit_gateway.outputs.ec2_transit_gateway_propagation_default_route_table_id
}
