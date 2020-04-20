module "network_acl" {
  source = "git::https://github.com/nitinda/terraform-module-aws-network-acl.git?ref=master"
  
  vpc_id = module.vpc.id
  subnet_ids = [
    module.vpc_subnet_public_1a.id,
    module.vpc_subnet_public_1b.id,
    module.vpc_subnet_private_1a.id,
    module.vpc_subnet_private_1b.id
  ]

  egress = [
    {
      protocol   = "all"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]

  ingress = [
    {
      protocol   = "all"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-network-acl"
    }
  )
}