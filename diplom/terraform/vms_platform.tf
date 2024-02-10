variable "vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Yandex compute image family"
}
variable "vm_01_resources" {
  type        = map
  default     = {
    cores = 2 
    memory = 2
    core_fraction = 50
  }
}
variable "vm_02_resources" {
  type        = map
  default     = {
    cores = 2
    memory = 1
    core_fraction = 25
  }
}
variable "vm_03_resources" {
  type        = map
  default     = {
    cores = 2
    memory = 1
    core_fraction = 25
  }
}
variable "vm_metadata" {
  type        = map
  default     = {
    serial_port = 1
    ssh_keys    = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzLRFw1JKFCcfdifAsrVbczI0C9pHld3oZM8Ul6gtjX ubuntu@vagrant"
  }
}
