module "vpc_internet_gateway" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-internet-gateway.git?ref=master"

  vpc_id = module.vpc.id
  tags   = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-vpc-internet-gateway"
    }
  )
}