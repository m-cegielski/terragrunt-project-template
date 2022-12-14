variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "create_tgw_attachment" {
  type    = bool
  default = true
}

variable "transit_gateway_id" {
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

variable "vpc_endpoints" {
  type    = list(string)
  default = ["ec2messages", "ssm", "ssmmessages"]
}

