terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "develop" {
  count          = length(var.subnets)
  name           = var.vpc_subnet_name
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
  HA             = true
}

output "vpc" {
  value = yandex_vpc_network.develop
}

output "subnet" {
  value = yandex_vpc_subnet.develop
}
