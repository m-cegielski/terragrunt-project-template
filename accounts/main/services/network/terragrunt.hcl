include "root" {
  path = find_in_parent_folders()
}

include "service" {
  path = "${dirname(find_in_parent_folders())}/../services/${basename(get_terragrunt_dir())}.hcl"
}

inputs = {
  cidr            = "10.0.16.0/20"
  private_subnets = ["10.0.16.0/24", "10.0.17.0/24"]

  attach_default_route_table = true
}
