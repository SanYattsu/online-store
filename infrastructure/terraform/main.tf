module "cloud-network" {
  source             = "./modules/cloud-network"
  network_zone       = var.network_zone
  domain-zone        = var.domain-zone
  kuber-external-ip  = module.kuber-instance.kuber-external-ip
  gitlab-external-ip = module.gitlab-instance.gitlab-external-ip
}

module "gitlab-instance" {
  source            = "./modules/gitlab-instance"
  network_zone      = var.network_zone
  domain-zone       = var.domain-zone
  subnet_id         = module.cloud-network.subnet_id
  security_group_id = module.cloud-network.security_group_id
}

module "kuber-instance" {
  source            = "./modules/kuber-instance"
  network_zone      = var.network_zone
  domain-zone       = var.domain-zone
  subnet_id         = module.cloud-network.subnet_id
  security_group_id = module.cloud-network.security_group_id
}

module "registry" {
  source        = "./modules/registry"
  cloud_secrets = var.cloud_secrets
}

module "backet" {
  source        = "./modules/backet"
  cloud_secrets = var.cloud_secrets
}
