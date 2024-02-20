## network.tf

resource "yandex_vpc_network" "network" {
  name = "network"
  folder_id = var.yc_folder_id
}


resource "yandex_vpc_subnet" "stage-subnet-a" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.yc_region_a
  name           = "stage-a"
  folder_id      = var.yc_folder_id
  network_id     = "${yandex_vpc_network.network.id}"
}

resource "yandex_vpc_subnet" "stage-subnet-b" {
  v4_cidr_blocks = ["10.3.0.0/16"]
  zone           = var.yc_region_b
  name           = "stage-b"
  folder_id      = var.yc_folder_id
  network_id     = "${yandex_vpc_network.network.id}"
}

resource "yandex_vpc_subnet" "stage-subnet-d" {
  v4_cidr_blocks = ["10.4.0.0/16"]
  zone           = var.yc_region_d
  name           = "stage-d"
  folder_id      = var.yc_folder_id
  network_id     = "${yandex_vpc_network.network.id}"
}
