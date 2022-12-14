locals {
  sorted_nfw_endpoints = values({ for sync_state in module.firewall.network_firewall_object.firewall_status[0]["sync_states"] : sync_state["availability_zone"] => sync_state["attachment"][0].endpoint_id })
}

resource "aws_route" "intra" {
  count = length(var.azs)

  route_table_id         = element(module.vpc.intra_route_table_ids, count.index)
  vpc_endpoint_id        = element(local.sorted_nfw_endpoints, count.index)
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "public" {
  count = length(var.azs)

  route_table_id         = element(module.vpc.public_route_table_ids, count.index)
  vpc_endpoint_id        = element(local.sorted_nfw_endpoints, count.index)
  destination_cidr_block = "10.0.0.0/8"
}
