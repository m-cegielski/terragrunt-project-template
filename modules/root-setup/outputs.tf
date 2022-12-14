output "organization" {
  value = aws_organizations_organization.this
}

output "organization_arn" {
  value = aws_organizations_organization.this.arn
}

output "organization_master_account_id" {
  description = "Management account id"
  value       = aws_organizations_organization.this.master_account_id
}

output "organization_all_accounts" {
  description = "Map of the organization units attributes where key is account name"
  value       = aws_organizations_account.this
}

output "all_account_ids" {
  value = [for k, v in aws_organizations_account.this : v.id]
}

output "state_bucket_name" {
  value = var.state_bucket_name
}

output "state_file_arn" {
  value = format("%s/%s/%s", module.state.s3_bucket_arn, var.state_bucket_path, "terraform.tfstate")
}

output "kms_key_alias" {
  value = aws_kms_alias.this.arn
}

output "kms_key_arn" {
  value = aws_kms_alias.this.target_key_arn
}
