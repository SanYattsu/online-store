resource "yandex_compute_instance" "kuber" {
  name                      = "kuber-cluster"
  platform_id               = "standard-v3"
  zone                      = var.network_zone
  allow_stopping_for_update = true

  resources {
    core_fraction = 20
    cores         = 4
    memory        = 4
  }

  # yc compute image list --folder-id standard-images | Select-String ubuntu-22
  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.instance_root_disk
    }
  }

  network_interface {
    nat                = true
    subnet_id          = var.subnet_id
    security_group_ids = ["${var.security_group_id}"]
    nat_ip_address     = yandex_vpc_address.addr.external_ipv4_address[0].address
  }

  metadata = {
    user-data = local.data
  }
}

# Static IP
resource "yandex_vpc_address" "addr" {
  name = "vm-adress-kuber"
  external_ipv4_address {
    zone_id = var.network_zone
  }
}
