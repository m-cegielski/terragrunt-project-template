variable "aws_service_access_principals" {
  type        = list(any)
  default     = ["cloudtrail.amazonaws.com", "ram.amazonaws.com"]
  description = "description"
}

variable "enabled_policy_types" {
  type        = list(any)
  default     = ["SERVICE_CONTROL_POLICY"]
  description = "List of Organizations Policy Types to enable in the Organization Root"
}

variable "feature_set" {
  type        = string
  default     = "ALL"
  description = ""
}

variable "accounts" {
  type = map(any)
}

variable "state_bucket_name" {
  type = string
}

variable "state_bucket_path" {
  type = string
}
