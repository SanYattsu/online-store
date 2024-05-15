output "gitlab-external-ip" {
  value = module.gitlab-instance.gitlab-external-ip
}

output "kuber-external-ip" {
  value = module.kuber-instance.kuber-external-ip
}
