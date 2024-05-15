terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net/"
    }
    bucket = "terraform-configs-practicum"
    key    = "terraform.tfstate"
    region = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id  = var.cloud_secrets.CLOUD_ID
  folder_id = var.cloud_secrets.FOLDER_ID
  zone      = var.network_zone
  token     = var.cloud_secrets.YC_TOKEN
}

# terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
# Для работы с s3 потребуются access_key и secret_key,
# которые загрузим из .aws/credenials файла следующего содержимого:
# [default]
# aws_access_key_id     = "***"
# aws_secret_access_key = "***"
provider "aws" {
  shared_credentials_files = "~/.aws/credenials"
  profile                  = "default"
}
