module "tgw_attachment" {
  source = "github.com/c-mi/terragrunt-project-template.git//modules/transit-gateway-attachment"

  name = var.name

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  transit_gateway_id    = var.transit_gateway_id
  create_tgw_attachment = var.create_tgw_attachment

  attach_default_route_table = var.attach_default_route_table
  default_route_table_id     = var.default_route_table_id
}
