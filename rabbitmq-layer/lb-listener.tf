module "alb_listener" {
  source = "git::https://github.com/nitinda/terraform-module-aws-lb-listener.git?ref=master"
  
  # Providers
  providers = {
    aws = aws.services
  }

  # ALB Listener
  load_balancer_arn = module.alb.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action = [
    {
      type             = "forward"
      target_group_arn = module.alb_target_group.arn
    }
  ]
}