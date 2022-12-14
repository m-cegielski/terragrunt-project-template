include "root" {
  path = find_in_parent_folders()
}

include "service" {
  path = "${dirname(find_in_parent_folders())}/../services/${basename(get_terragrunt_dir())}.hcl"
}

inputs = {
  cidr = "10.0.32.0/20"

  azs             = ["eu-west-1a", "eu-west-1b"]
  intra_subnets   = ["10.0.32.0/24", "10.0.33.0/24"]
  private_subnets = ["10.0.34.0/24", "10.0.35.0/24"]
  public_subnets  = ["10.0.36.0/24", "10.0.37.0/24"]

  rule_groups = [
    {
      name        = "block-public-dns"
      capacity    = 100
      type        = "STATEFUL"
      description = "Block public DNS resolvers"

      stateful_rule = [
        {
          action           = "DROP"
          destination      = "ANY"
          destination_port = "ANY"
          direction        = "ANY"
          protocol         = "DNS"
          source           = "ANY"
          source_port      = "ANY"
          rule_option      = "sid:50"
        }
      ]
    },
    {
      name        = "drop-icmp"
      capacity    = 100
      type        = "STATELESS"
      description = "Block ICMP traffic"
      priority    = 1

      stateless_rule = [
        {
          priority    = 1
          actions     = ["aws:drop"]
          source      = "0.0.0.0/0"
          destination = "0.0.0.0/0"
          protocols   = [1]
        }
      ]
    },
    {
      name        = "whitelist"
      capacity    = 25000
      type        = "STATEFUL"
      description = "Filter outgoing traffic"

      rule_variables = [
        {
          key = "HOME_NET"
          ip_set = [
            "10.0.0.0/16",
          ]
        }
      ]

      rules_string = <<-EOT
        alert tls $HOME_NET any -> $EXTERNAL_NET any (msg:"Drop all outgoing TLS traffic that does not match whitelist"; priority:5; flow:to_server, established; sid:1700; rev:1;)
        alert http $HOME_NET any -> $EXTERNAL_NET any (http.header_names; content:"|0d 0a|"; startswith; msg:"Drop all outgoing HTTP traffic"; priority:5; flow:to_server, established; sid:1800; rev:1;)
        alert ip $HOME_NET any -> $EXTERNAL_NET any (msg: "Drop non-TCP traffic"; ip_proto:!TCP; priority:10; sid:1900; rev:1;)
        alert tcp $HOME_NET any -> $EXTERNAL_NET !443 (msg:"Drop All TCP instead of allowlisted"; flow:established,to_server; priority:10; sid:2100; rev:1;)
      EOT
    }
  ]

}
