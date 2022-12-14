module "firewall" {
  source = "github.com/c-mi/terraform-aws-network-firewall.git"

  name   = var.name
  vpc_id = module.vpc.vpc_id

  subnet_mapping = [
    { subnet_id = module.vpc.private_subnets[0] },
    { subnet_id = module.vpc.private_subnets[1] },
  ]

  rule_groups = var.rule_groups

  logging_configuration = [
    {
      log_destination_config = {
        logGroup             = aws_cloudwatch_log_group.this.name
        log_destination_type = "CloudWatchLogs"
        log_type             = "ALERT"
      },
    }
  ]
}
