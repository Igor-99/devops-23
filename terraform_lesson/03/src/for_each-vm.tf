resource "yandex_compute_instance" "each_vm" {
  depends_on = [resource.yandex_compute_instance.count_vm]
  for_each = var.each_vm
  name        = each.key
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type        = "network-hdd"
      size        = each.value.disk
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
