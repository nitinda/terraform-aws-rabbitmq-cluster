data "aws_iam_policy_document" "iam_policy_document_ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

module "iam_role_ec2" {
  source = "git::https://github.com/nitinda/terraform-module-aws-iam-role.git?ref=master"

  providers = {
    aws  = aws.services
  }

  ## Tags
  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "rabbitmq-iam-role-ec2"
    }
  )
  
  ## IAM Role
  name                  = "rabbitmq-iam-role-ec2"
  assume_role_policy    = data.aws_iam_policy_document.iam_policy_document_ec2.json
  description           = "IAM Role for Rabbitmq ec2 nodes"
  force_detach_policies = true
}


module "iam_instance_profile_ec2" {
  source = "git::https://github.com/nitinda/terraform-module-aws-iam-instance-profile.git?ref=master"

  providers = {
    aws = aws.services
  }

  ## IAM Role
  name = "rabbitmq-iam-role-ec2"
  role = module.iam_role_ec2.name
}

module "iam_role_policy_attachment_AmazonEC2RoleforSSM" {
  source = "git::https://github.com/nitinda/terraform-module-aws-iam-role-policy-attachment.git?ref=master"

  providers = {
    aws = aws.services
  }

  ## IAM Role Policy
  role       = module.iam_role_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

}

module "iam_role_policy_attachment_CloudWatchLogsFullAccess" {
  source = "git::https://github.com/nitinda/terraform-module-aws-iam-role-policy-attachment.git?ref=master"

  providers = {
    aws = aws.services
  }

  ## IAM Role Policy
  role       = module.iam_role_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"

}

module "iam_role_policy_attachment_AmazonEC2ReadOnlyAccess" {
  source = "git::https://github.com/nitinda/terraform-module-aws-iam-role-policy-attachment.git?ref=master"

  providers = {
    aws = aws.services
  }

  ## IAM Role Policy
  role       = module.iam_role_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"

}