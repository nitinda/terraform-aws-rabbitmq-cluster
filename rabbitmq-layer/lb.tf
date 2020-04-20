module "alb" {
  source = "git::https://github.com/nitinda/terraform-module-aws-lb.git?ref=master"

  providers = {
    aws = aws.services
  }

  name = "rabbitmq-alb"

  security_groups = [
      module.security_group_alb.id
  ]

  subnets = [
      module.vpc_subnet_public_1a.id,
      module.vpc_subnet_public_1b.id
  ]

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-alb"
    }
  )
}