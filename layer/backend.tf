terraform {
  backend "local" {
    path = "../terraform-state-file/aws-services/terraform.tfstate"
  }
}