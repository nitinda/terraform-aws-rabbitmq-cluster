module "vpc" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc.git?ref=master"

  providers = {
    aws = aws.services
  }


  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-vpc"
    }
  )
}

