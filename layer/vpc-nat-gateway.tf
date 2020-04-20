module "vpc_nat_gateway_private_1a" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-nat-gateway.git?ref=master"

  allocation_id = module.eip_nat_gateway_1a.id
  subnet_id     = module.vpc_subnet_public_1a.id
  tags          = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-vpc-internet-gateway"
    }
  )
}

module "vpc_nat_gateway_private_1b" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-nat-gateway.git?ref=master"

  allocation_id = module.eip_nat_gateway_1b.id
  subnet_id     = module.vpc_subnet_public_1b.id
  tags          = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-vpc-internet-gateway"
    }
  )
}