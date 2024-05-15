locals {
  data = templatefile("${path.module}/files/cloud_config.yaml", {
    user_name = "${var.user_name}",
    ssh_pub   = file("~/.ssh/gitlab.pub")
  })
}

data "template_file" "init-script" {
  template = file("${path.module}/files/init-script.tpl.sh")
  vars = {
    dns     = "gitlab.${var.domain-zone}"
    host_ip = "${yandex_vpc_address.addr.external_ipv4_address[0].address}",
  }
}

variable "user_name" {
  default = "igor"
}

variable "domain-zone" {
  default = null
}

variable "network_zone" {
  default = null
}

variable "subnet_id" {
  default = null
}

variable "security_group_id" {
  default = null
}

variable "image_id" {
  # ubuntu-22-04-lts-v20240422
  default = "fd82vchjp2kdjiuam29k"
}

variable "instance_root_disk" {
  default = "33"
}
