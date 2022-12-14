module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.11.3"

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = try([aws_security_group.this[0].id], [])

  endpoints = {
    for endpoint in var.vpc_endpoints : endpoint => {
      service = endpoint
      tags    = { Name = "${endpoint}-vpc-endpoint" }
    }
  }
}

resource "aws_security_group" "this" {
  count = length(var.vpc_endpoints) > 0 ? 1 : 0

  description = "Vpc enpoint security group"
  name        = "${var.name}-vpc-endpoint-sg"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${var.name}-vpc-endpoint-sg"
  }
}

resource "aws_security_group_rule" "this_ingress" {
  count = length(var.vpc_endpoints) > 0 ? 1 : 0

  description = "Vpc enpoints ingress"
  type        = "ingress"
  from_port   = "443"
  to_port     = "443"
  protocol    = "TCP"
  cidr_blocks = ["10.0.0.0/8"]

  security_group_id = aws_security_group.this[0].id
}

resource "aws_security_group_rule" "this_egress" {
  count = length(var.vpc_endpoints) > 0 ? 1 : 0

  description = "Vpc enpoints egress"
  type        = "egress"
  from_port   = "0"
  to_port     = "65535"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.this[0].id
}
