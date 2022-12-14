variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "intra_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "transit_gateway_id" {
  type = string
}

variable "default_route_table_id" {
  type = string
}

variable "rule_groups" {
  type = any
}
