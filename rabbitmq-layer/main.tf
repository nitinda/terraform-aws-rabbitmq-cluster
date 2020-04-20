provider "aws" {
  alias  = "services"
  region = var.region
}

provider "aws" {
  region = var.region
}

