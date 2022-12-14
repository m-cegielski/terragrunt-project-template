module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = var.name

  cidr = var.cidr
  azs  = ["eu-west-1a", "eu-west-1b"]

  private_subnets = var.private_subnets

  enable_dns_hostnames             = true
  enable_dns_support               = true
  enable_dhcp_options              = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]
}
