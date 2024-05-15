resource "yandex_container_registry" "momo-registry" {
  name = "momo-registry"
  folder_id = "${var.cloud_secrets.FOLDER_ID}"
}
