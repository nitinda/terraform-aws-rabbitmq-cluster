module "eip_nat_gateway_1a" {
  source = "git::https://github.com/nitinda/terraform-module-aws-eip.git?ref=master"

  vpc  = true
  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-eip-nat-gateway-1a"
    }
  )
}

module "eip_nat_gateway_1b" {
  source = "git::https://github.com/nitinda/terraform-module-aws-eip.git?ref=master"

  vpc  = true
  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-eip-nat-gateway-1b"
    }
  )
}