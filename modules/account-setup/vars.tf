variable "sec_account_id" {
  type = string
}

variable "deploy_account_id" {
  type = string
}

variable "member_account_ids" {
  type = list(string)
}

variable "account_alias" {
  type = string
}

variable "create_state_bucket" {
  type    = bool
  default = false
}

variable "state_bucket_name" {
  type    = string
  default = ""
}

variable "users" {
  type    = map(any)
  default = {}
}

variable "root_state_file_arn" {
  type    = string
  default = ""
}

variable "root_state_kms_key" {
  type    = string
  default = ""
}
