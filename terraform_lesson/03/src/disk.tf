resource "yandex_compute_disk" "disk" {
  count = 3
  name = "dis-${count.index}"
  type = "network-hdd"
  size = 1
}

resource "yandex_compute_instance" "disk_vm" {
  depends_on = [resource.yandex_compute_disk.disk]
  count = 1
  name        = "netology-vm-disk-${count.index}"
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
       disk_id = secondary_disk.value.id
    }
  }
  
  resources {
    cores         = 2
    memory        = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type        = "network-hdd"
      size        = 10
    }
  }
  

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = toset([yandex_vpc_security_group.example.id])
  }
  
 

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = local.server_ssh_key
  }


}
