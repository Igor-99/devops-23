resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_family 
}
resource "yandex_compute_instance" "vm" {
  name        = "netology_01"
  platform_id = "netology_01.local"
  resources {
    cores         = var.vm_01_resources.cores
    memory        = var.vm_01_resources.memory
    core_fraction = var.vm_01_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = "20"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys           = var.vm_metadata.ssh_keys
  }

}
resource "yandex_compute_instance" "vm2" {
  name        = "netology_02"
  platform_id = "netology_02.local"
  resources {
    cores         = var.vm_02_resources.cores
    memory        = var.vm_02_resources.memory
    core_fraction = var.vm_02_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = "20"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys           = var.vm_metadata.ssh_keys
  }

}
resource "yandex_compute_instance" "vm3" {
  name        = "netology_03"
  platform_id = "netology_03.local"
  resources {
    cores         = var.vm_03_resources.cores
    memory        = var.vm_03_resources.memory
    core_fraction = var.vm_03_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = "20"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys           = var.vm_metadata.ssh_keys
  }

}
