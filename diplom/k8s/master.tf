## masters.tf

resource "yandex_compute_instance" "master" {
  folder_id = var.yc_folder_id
  name      = "master"
  zone      = var.yc_region_a
  hostname  = "master.local"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8li2lvvfc6bdj4c787"
      size = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.stage-subnet-a.id}"
    nat = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("./jenkins.yml")}"
  }
}
