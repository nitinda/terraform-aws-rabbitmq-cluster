module "alb_target_group" {
  source = "git::https://github.com/nitinda/terraform-module-aws-lb-tg.git?ref=master"

  # Providers
  providers = {
    aws = aws.services
  }

  # ALB Target Group
  name                 = "rabbitmq-alb-tg"
  port                 = 15672
  protocol             = "HTTP"
  vpc_id               = module.vpc.id
  deregistration_delay = 0

  stickiness = {
      enabled = false
  }

  health_check         = {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      interval            = 5
      matcher             = "200"
      path                = "/"
      port                = "traffic-port"
      protocol            = "HTTP"
      timeout             = 3
  }
  

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-alb-tg"
    }
  )
}