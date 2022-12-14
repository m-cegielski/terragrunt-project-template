module "tgw_attachment" {
  source = "github.com/c-mi/terragrunt-project-template.git//modules/transit-gateway-attachment"

  name = var.name

  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.intra_subnets
  appliance_mode_support     = true
  transit_gateway_id         = var.transit_gateway_id
  default_route_table_id     = var.default_route_table_id
  attach_default_route_table = true
}
