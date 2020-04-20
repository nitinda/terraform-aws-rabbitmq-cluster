module "random_string" {
  source = "git::https://github.com/nitinda/terraform-module-random-string.git?ref=master"
  
  # Providers
  providers = {
    random = random.services
  }

  length = 23
  special = false
  min_upper = 23  
}