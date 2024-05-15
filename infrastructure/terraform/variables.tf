variable "cloud_secrets" {
  description = "Credentials for Yandex cloud"
  type = object({
    YC_TOKEN  = string
    CLOUD_ID  = string
    FOLDER_ID = string
    SUBNET_ID = string
  })
  sensitive = true
  nullable  = false
}

variable "network_zone" {
  default     = "ru-central1-a"
  type        = string
  description = "Instance availability zone"
  validation {
    condition     = contains(toset(["ru-central1-a", "ru-central1-b"]), var.network_zone)
    error_message = "Select availability zone from the list: ru-central1-a, ru-central1-b."
  }
  sensitive = true
  nullable  = false
}

variable "domain-zone" {
  default     = "practi-testing.fun"
  type        = string
  description = "Domain zone"
}
