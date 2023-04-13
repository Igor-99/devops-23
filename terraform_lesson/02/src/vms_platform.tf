###first VM

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Yandex compute image family"
}
variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Yandex compute instans platform id"
}
variable "vm_web_resources" {
  type        = map
  default     = {
    cores = 2 
    memory = 1
    core_fraction = 5
  }
}
variable "vm_db_resources" {
  type        = map
  default     = {
    cores = 2
    memory = 2
    core_fraction = 20
  }
}
variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Yandex compute image family"
}
variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Yandex compute instans platform id"
}
variable "vm_metadata" {
  type        = map
  default     = {
    serial_port = 1
    ssh_keys    = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzLRFw1JKFCcfdifAsrVbczI0C9pHld3oZM8Ul6gtjX ubuntu@vagrant"
  }
}
