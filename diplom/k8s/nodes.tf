## nodes.tf

resource "yandex_compute_instance" "node1" {
  folder_id = var.yc_folder_id
  name      = "node1"
  zone      = "ru-central1-a"
  hostname  = "node1.local"
  platform_id = "standard-v2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8li2lvvfc6bdj4c787"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.stage-subnet-a.id}"
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("./jenkins.yml")}"
  }
}

resource "yandex_compute_instance" "node2" {
  folder_id = var.yc_folder_id
  name      = "node2"
  zone      = "ru-central1-a"
  hostname  = "node2.local"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8li2lvvfc6bdj4c787"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.stage-subnet-a.id}"
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("./jenkins.yml")}"
  }
}

resource "yandex_compute_instance" "node3" {
  provider  = yandex.d
  folder_id = var.yc_folder_id
  name      = "node3"
  zone      = "ru-central1-d"
  hostname  = "node3.local"
  platform_id = "standard-v2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8li2lvvfc6bdj4c787"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.stage-subnet-d.id}"
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("./jenkins.yml")}"
  }
}
