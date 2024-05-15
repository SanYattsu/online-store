resource "yandex_iam_service_account" "sa" {
  name      = "sa"
  folder_id = var.cloud_secrets.FOLDER_ID
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.cloud_secrets.FOLDER_ID
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-pusher" {
  folder_id = var.cloud_secrets.FOLDER_ID
  role      = "container-registry.images.pusher"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  folder_id = var.cloud_secrets.FOLDER_ID
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "momo-static" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "momo-static"
  acl        = "public-read"
  max_size   = 10485760
}
