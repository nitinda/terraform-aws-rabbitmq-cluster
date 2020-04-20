module "autoscaling_group_ec2" {
  source = "git::https://github.com/nitinda/terraform-module-aws-autoscaling-group.git?ref=master"

  providers = {
    aws = aws.services
  }
  
  name_prefix               = "rabbitmq-asg-ec2-"
  desired_capacity          = 3
  max_size                  = 5
  min_size                  = 0
  default_cooldown          = 1
  vpc_zone_identifier       = [
    module.vpc_subnet_private_1a.id,
    module.vpc_subnet_private_1b.id
  ]
  health_check_grace_period = 1
  target_group_arns = [
      module.alb_target_group.arn
  ]
  mixed_instances_policy    = {
      launch_template = {
          launch_template_specification = {
              launch_template_id = module.launch_template.id
              version            = "$Latest"
          }
          override = [
              {
                  instance_type = "t3.large"
              },
              {
                  instance_type = "t3.xlarge"
              }
          ]
      }
      instances_distribution = {
          spot_allocation_strategy                 = "capacity-optimized"
          on_demand_base_capacity                  = 0
          on_demand_percentage_above_base_capacity = 0
      }
  }

  tag = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-ec2-insance"
      Application = "rabbitmq"
      ApplicationCategory = "rabbitmq-server"
    }
  )
}