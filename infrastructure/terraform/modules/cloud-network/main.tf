resource "yandex_vpc_network" "momo-net" {
  name = "momo-network"
}

resource "yandex_vpc_subnet" "momo-subnet" {
  network_id     = yandex_vpc_network.momo-net.id
  v4_cidr_blocks = ["10.38.8.0/24"]
  name           = "${resource.yandex_vpc_network.momo-net.name}-${var.network_zone}"
}

resource "yandex_vpc_security_group" "yandex-sg" {
  name       = "momo-security-group"
  network_id = resource.yandex_vpc_network.momo-net.id

  dynamic "ingress" {
    for_each = ["22", "2222"]
    content {
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = ingress.value
      to_port        = ingress.value
    }
  }

  ingress {
    from_port      = 6443
    to_port        = 6443
    protocol       = "TCP"
    v4_cidr_blocks = ["1.2.3.4/32"]
  }

  ingress {
    from_port      = 80
    to_port        = 80
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port      = 443
    to_port        = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "ICMP"
    description    = "Inner ICMP"
    v4_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }

  ingress {
    description    = "Permit ANY for momo-subnet"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["${yandex_vpc_subnet.momo-subnet.v4_cidr_blocks[0]}"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_dns_zone" "momo-zone" {
  name        = "momo-public-zone"
  description = "momo dns zone"

  zone             = "${var.domain-zone}."
  public           = true
  private_networks = [yandex_vpc_network.momo-net.id]
  
  deletion_protection = true
}

resource "yandex_dns_recordset" "rs_kuber" {
  zone_id = yandex_dns_zone.momo-zone.id
  name    = "store.${var.domain-zone}."
  type    = "A"
  ttl     = 600
  data    = ["${var.kuber-external-ip}"]
}

resource "yandex_dns_recordset" "rs_grafana" {
  zone_id = yandex_dns_zone.momo-zone.id
  name    = "grafana.${var.domain-zone}."
  type    = "A"
  ttl     = 600
  data    = ["${var.kuber-external-ip}"]
}

resource "yandex_dns_recordset" "rs_gitlab" {
  zone_id = yandex_dns_zone.momo-zone.id
  name    = "gitlab.${var.domain-zone}."
  type    = "A"
  ttl     = 600
  data    = ["${var.gitlab-external-ip}"]
}