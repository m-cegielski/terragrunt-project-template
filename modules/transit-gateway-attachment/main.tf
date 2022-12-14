resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.create_tgw_attachment ? 1 : 0

  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = var.vpc_id

  transit_gateway_default_route_table_association = var.enable_default_route_table_association
  transit_gateway_default_route_table_propagation = var.enable_default_route_table_propagation

  appliance_mode_support = var.appliance_mode_support ? "enable" : "disable"
  dns_support            = var.dns_support ? "enable" : "disable"

  tags = {
    Name = var.name
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.create_tgw_attachment && var.attach_default_route_table ? 1 : 0

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this[0].id
  transit_gateway_route_table_id = var.default_route_table_id
}
