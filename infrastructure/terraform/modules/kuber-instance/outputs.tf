output "kuber-external-ip" {
  value = yandex_compute_instance.kuber.network_interface.0.nat_ip_address
}
