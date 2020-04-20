# Glboal
variable "region" {
  description = "AWS region that will be used to create resources in."
  default     = "eu-central-1"
}

variable common_tags {
  description = "Resources Tags"
  type = map(string)
  default = {
    Project      = "POC"
    Owner        = "Platform Team"
    Environment  = "prod"
    BusinessUnit = "Platform Team"
  }
}


