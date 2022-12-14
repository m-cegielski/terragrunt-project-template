variable "create_tgw_attachment" {
  type    = bool
  default = true
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "transit_gateway_id" {
  type = string
}

variable "enable_default_route_table_association" {
  type    = bool
  default = false
}

variable "enable_default_route_table_propagation" {
  type    = bool
  default = true
}

variable "appliance_mode_support" {
  type    = bool
  default = false
}

variable "dns_support" {
  type    = bool
  default = true
}

variable "name" {
  type = string
}

variable "attach_default_route_table" {
  type    = bool
  default = false
}

variable "default_route_table_id" {
  type    = string
  default = ""
}
