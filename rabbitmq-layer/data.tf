data "http" "workstation_external_ip" {
  url = "http://icanhazip.com"
}

data "aws_ami" "ami_ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"] # Canonical
}

data "template_file" "userdata" {
  template = "${file("${path.module}/files/shell/userdata.sh")}"

  vars = {
    RANDOM_COOKIE = module.random_string.result
    CLUSTER_NAME  = "rabbitmq-cluster-poc"
  }
}