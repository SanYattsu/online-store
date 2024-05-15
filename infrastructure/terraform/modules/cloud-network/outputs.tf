output "subnet_id" {
  value = resource.yandex_vpc_subnet.momo-subnet.id
}

output "security_group_id" {
  value = resource.yandex_vpc_security_group.yandex-sg.id
}
