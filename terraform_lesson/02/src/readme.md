## Задание 1
4) Было не допустимое количество ядер 1, а допустимое количество ядер: 2, 4
5) scheduling_policy — политика планирования. Чтобы создать прерываемую ВМ, укажите preemptible = true
core_fraction	Базовый уровень производительности vCPU. Выбрав данный уровень производимлсти мы экономим денежные средства на гранте, а прерывание позваляет прервать работу ВМ.
![s1](https://user-images.githubusercontent.com/29104612/231841081-ae67e0b9-880e-4654-8f41-5b91cab69379.png)
![s2](https://user-images.githubusercontent.com/29104612/231841099-24b44fc7-354f-4837-a319-3483d5d572c1.png)

## Задание 4
![s3](https://user-images.githubusercontent.com/29104612/231841330-fc205e51-88c0-4b06-87a0-cf061df18df2.png)

## Задание 5

Файл locals.tf
```
locals {
  first_name_vm  = "netology-${var.vpc_name}-${var.project}-${var.role[0]}"
  second_name_vm = "netology-${var.vpc_name}-${var.project}-${var.role[1]}"
}
```
Данные из файла variables.tf
```
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "project" {
  type        = string
  default     = "platform"
}

variable "role" {
  type        = list(string)
  default     = [
    "web",
    "db",
    ]
}
```

## Задание 6
```
resource "yandex_compute_instance" "platform" {
  name        = local.first_name_vm
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_resources.cores
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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
    serial-port-enable = var.vm_metadata.serial_port
    ssh-keys           = var.vm_metadata.ssh_keys
  }

}
resource "yandex_compute_instance" "platform_db" {
  name        = local.second_name_vm
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_resources.cores
    memory        = var.vm_db_resources.memory
    core_fraction = var.vm_db_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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
    serial-port-enable = var.vm_metadata.serial_port
    ssh-keys           = var.vm_metadata.ssh_keys
  }
```


## Задание 7
1) 
```
local.test_list[1]
"staging"
```
2)
```
length(local.test_list)
3
```
3)
```
local.test_map.admin
"John"
```
4)
```
"${local.test_map.admin} is admin for ${local.test_list[2]} server based on OS ${local.servers.stage.image} with ${local.servers.stage.cpu} vcpu, ${local.servers.stage.ram} ram and ${length(local.servers.stage.disks)} virtual disks"
"John is admin for production server based on OS ubuntu-20-04 with 4 vcpu, 8 ram and 2 virtual disks"
```
