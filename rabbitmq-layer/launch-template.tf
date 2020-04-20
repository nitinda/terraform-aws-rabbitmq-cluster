module "launch_template" {
  source = "git::https://github.com/nitinda/terraform-module-aws-launch-template.git?ref=master"

  providers = {
    aws = aws.services
  }

  name_prefix            = "rabbitmq-lt-"
  description            = "RabbitMQ EC2 Launch Template"
  ebs_optimized          = true
  image_id               = data.aws_ami.ami_ubuntu.id
  vpc_security_group_ids = [ module.security_group_ec2.id ]
  user_data              = base64encode("${data.template_file.userdata.rendered}")
  iam_instance_profile   = {
    name = module.iam_instance_profile_ec2.name
  }

  instance_initiated_shutdown_behavior = "terminate"
  
  block_device_mappings = {
    device_name = "/dev/sda1"
    ebs = {
      volume_size = 20
    }
  }

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = merge(var.common_tags, map("Name", "rabbitmq-ec2-instance",))
    },
    {
      resource_type = "volume"
      tags          = merge(var.common_tags, map("Name", "rabbitmq-ec2-instance-volume",))
    }
  ]

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-iam-role-ec2"
    }
  )
}