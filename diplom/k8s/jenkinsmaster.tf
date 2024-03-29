## jenkinsmaster.tf

resource "yandex_compute_instance" "jenkins-master01" {
  folder_id = var.yc_folder_id
  name = "jenkins-master-01"
  zone = var.yc_region_a
  hostname = "jenkins-master-01.ru-central1.internal"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8jvcoeij6u9se84dt5"
      size = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.stage-subnet-a.id}"
    nat = true
  }

  metadata = {
    user-data = "${file("./jenkins.yml")}"
  }
}
