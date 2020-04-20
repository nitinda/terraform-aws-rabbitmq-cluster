module "vpc_route_table_public" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-route-table.git?ref=master"
  
  vpc_id = module.vpc.id
  route  = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.vpc_internet_gateway.id
    }
  ]
  tags   = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-vpc-route-table-public"
    }
  )
}

module "route_table_association_public_1a" {
  source = "git::https://github.com/nitinda/terraform-module-aws-route-table-association.git?ref=master"
  
  subnet_id      = module.vpc_subnet_public_1a.id
  route_table_id = module.vpc_route_table_public.id
}

module "route_table_association_public_1b" {
  source = "git::https://github.com/nitinda/terraform-module-aws-route-table-association.git?ref=master"
  
  subnet_id      = module.vpc_subnet_public_1b.id
  route_table_id = module.vpc_route_table_public.id
}


### Private

module "vpc_route_table_private_1a" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-route-table.git?ref=master"
  
  vpc_id = module.vpc.id
  route  = [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = module.vpc_nat_gateway_private_1a.id
    }
  ]
  tags   = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-vpc-route-table-private-1a"
    }
  )
}

module "route_table_association_private_1a" {
  source = "git::https://github.com/nitinda/terraform-module-aws-route-table-association.git?ref=master"
  
  subnet_id      = module.vpc_subnet_private_1a.id
  route_table_id = module.vpc_route_table_private_1a.id
}

module "vpc_route_table_private_1b" {
  source = "git::https://github.com/nitinda/terraform-module-aws-vpc-route-table.git?ref=master"
  
  vpc_id = module.vpc.id
  route  = [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = module.vpc_nat_gateway_private_1b.id
    }
  ]
  tags   = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-vpc-route-table-private-1b"
    }
  )
}

module "route_table_association_private_1b" {
  source = "git::https://github.com/nitinda/terraform-module-aws-route-table-association.git?ref=master"
  
  subnet_id      = module.vpc_subnet_private_1b.id
  route_table_id = module.vpc_route_table_private_1b.id
}