output "id" {
  value = try(aws_ec2_transit_gateway_vpc_attachment.this[0].id, "")
}
