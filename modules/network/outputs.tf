output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "tgw_attachment_id" {
  value = module.tgw_attachment.id
}
