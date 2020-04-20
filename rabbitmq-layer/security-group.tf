module "security_group_ec2" {
  source = "git::https://github.com/nitinda/terraform-module-aws-security-group.git?ref=master"

  name_prefix            = "rabbitmq-sg-ec2-"
  description            = "EC2 Security Group that allows traffic from whitelisted ips"
  vpc_id                 = module.vpc.id
  revoke_rules_on_delete = true
  ingress = [
    {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        description = "Ingress rule that allows traffic from whitelisted ips"
        cidr_blocks = [ module.vpc.cidr_block ]
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "The egress rule allows all ports"
    }
  ]

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-sg-ec2"
    }
  )
}

### ALB
module "security_group_alb" {
  source = "git::https://github.com/nitinda/terraform-module-aws-security-group.git?ref=master"

  name_prefix            = "rabbitmq-sg-alb-"
  description            = "ALB Security Group that allows traffic from whitelisted ips"
  vpc_id                 = module.vpc.id
  revoke_rules_on_delete = true
  ingress = [
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        description = "Ingress rule that allows traffic from whitelisted ips"
        cidr_blocks = [ local.workstation_external_cidr ]
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "The egress rule allows all ports"
    }
  ]

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-sg-alb"
    }
  )
}