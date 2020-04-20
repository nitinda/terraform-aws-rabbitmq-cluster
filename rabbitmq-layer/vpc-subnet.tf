module "vpc_subnet_public_1a" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-subnet.git?ref=master"

  vpc_id            = module.vpc.id
  cidr_block        = "10.0.0.0/18"
  availability_zone = "eu-central-1a"
  tags       = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-subnet-public-1a"
    }
  )
}


module "vpc_subnet_public_1b" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-subnet.git?ref=master"

  vpc_id            = module.vpc.id
  cidr_block        = "10.0.64.0/18"
  availability_zone = "eu-central-1b"
  tags       = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-subnet-public-1b"
    }
  )
}


### Private

module "vpc_subnet_private_1a" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-subnet.git?ref=master"

  vpc_id            = module.vpc.id
  cidr_block        = "10.0.128.0/18"
  availability_zone = "eu-central-1a"
  tags       = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-subnet-private-1a"
    }
  )
}

module "vpc_subnet_private_1b" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-subnet.git?ref=master"

  vpc_id            = module.vpc.id
  cidr_block        = "10.0.192.0/18"
  availability_zone = "eu-central-1b"
  tags       = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-subnet-private-1b"
    }
  )
}
