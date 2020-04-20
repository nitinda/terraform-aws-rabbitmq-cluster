provider "aws" {
  alias  = "services"
  region = var.region
}

provider "random" {
  alias  = "services"
}