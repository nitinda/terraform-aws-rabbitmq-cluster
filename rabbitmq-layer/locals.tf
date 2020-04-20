locals {
  workstation_external_cidr = "${chomp(data.http.workstation_external_ip.body)}/32"
}



# resource "random_string" "random" {
#   length = 23
#   special = false
#   min_upper = 23
# }

# output "random_string" {
#   value = random_string.random.result
# }
