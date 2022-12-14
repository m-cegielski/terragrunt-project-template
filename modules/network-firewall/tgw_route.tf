resource "aws_ec2_transit_gateway_route" "this" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = module.tgw_attachment.id
  transit_gateway_route_table_id = var.default_route_table_id
}
