resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = var.transit_gateway_id

  tags = {
    Name = var.name
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  transit_gateway_attachment_id  = var.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = toset(var.transit_gateway_propagated_attachments)

  transit_gateway_attachment_id  = each.key
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_tag" "this" {
  resource_id = var.transit_gateway_attachment_id
  key         = "Name"
  value       = replace(var.name, "rt", "attachment")
}

resource "aws_ec2_transit_gateway_route" "this" {
  count = var.create_egress_route ? 1 : 0

  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = var.egress_tgw_attachement
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}
