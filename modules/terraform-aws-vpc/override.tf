################
# Publiс routes
################
resource "aws_route_table" "public" {
  # Create one or multiple route tables for public subnets, based on "multiple_public_route_tables" variable and list of provided public subnet cidrs
  # Default behaviour (var.multiple_public_route_tables equals false) is to create a single route table, but in a network firewall scenario, different routes are required - depending on AZs
  count = var.create_vpc && length(var.public_subnets) > 0 ? (var.multiple_public_route_tables ? length(var.public_subnets) : 1) : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      "Name" = format("%s-${var.public_subnet_suffix}", var.name)
    },
    var.tags,
    var.public_route_table_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  # Create one or multiple routes to IGW for public subnets, based on "multiple_public_route_tables" variable and list of provided public subnet cidrs
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? (var.multiple_public_route_tables ? length(var.public_subnets) : 1) : 0

  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "public_internet_gateway_ipv6" {
  # Create one or multiple routes to IGW for public subnets, based on "multiple_public_route_tables" variable and list of provided public subnet cidrs
  count = var.create_vpc && var.create_igw && var.enable_ipv6 && length(var.public_subnets) > 0 ? (var.multiple_public_route_tables ? length(var.public_subnets) : 1) : 0

  route_table_id              = aws_route_table.public[0].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.this[0].id
}

#################
# Intra routes
#################
resource "aws_route_table" "intra" {
  # Create one or multiple route tables for intra subnets, based on "multiple_intra_route_tables" variable and list of provided intra subnet cidrs
  # Default behaviour (var.multiple_intra_route_tables equals false) is to create a single route table, but in a network firewall scenario, different routes are required - depending on AZs
  count = var.create_vpc && length(var.intra_subnets) > 0 ? (var.multiple_intra_route_tables ? length(var.intra_subnets) : 1) : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      "Name" = "${var.name}-${var.intra_subnet_suffix}"
    },
    var.tags,
    var.intra_route_table_tags,
  )
}
