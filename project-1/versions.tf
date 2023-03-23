terraform {
  required_version = ">= 0.14.5"

  required_providers {
    local = ">= 2.0.0"
    tls   = ">= 3.0.0"
  }
}

provider "local" {}

provider "tls" {}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "tls_public_key" "ssh_key" {
  private_key_pem = tls_private_key.ssh_key.private_key_pem
}

output "public_key" {
  value     = data.tls_public_key.ssh_key.public_key_openssh
  sensitive = true
}
output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

locals {
    private_key = tls_private_key.ssh_key.private_key_pem
    public_key  = data.tls_public_key.ssh_key.public_key_openssh
}

data "template_file" "example_yaml" {
  template = "${file("${path.module}/cloud-config.yaml.tpl")}"
  vars = {
    private_key = local.private_key
    public_key = local.public_key
  }
}

resource "local_file" "cloud_config" {
  filename = "${path.module}/cloud-configs.yaml"
  content  = indent(4, data.template_file.example_yaml.rendered)
  file_permission = "0644"
}

