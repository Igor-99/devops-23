data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_compute_instance" "count_vm" {
  count = 2 
  name        = "netology-vm-${count.index}"
  resources {
    cores         = 2
    memory        = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type        = "network-hdd"
      size        = "10"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = local.server_ssh_key
  }

}
