locals {
  data = templatefile("${path.module}/cloud_config.yaml", {
    user_name = "${var.user_name}",
    ssh_pub   = file("~/.ssh/k3s.pub")
    host_ip = "${yandex_vpc_address.addr.external_ipv4_address[0].address}"
  })
}

variable "user_name" {
  default = "igor"
}

variable "network_zone" {
  default = null
}

variable "domain-zone" {
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
  default = "30"
}
