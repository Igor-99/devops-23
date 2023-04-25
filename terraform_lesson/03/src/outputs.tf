output "VMs_count" {
  value = toset([for count_vm in yandex_compute_instance.count_vm : {
  "name" = "${count_vm.name}",
  "id"   = "${count_vm.id}",
  "fqdn" = "${count_vm.fqdn}"
 }])
}

output "VMs_each" {
  value = toset([for each_vm in yandex_compute_instance.each_vm : {
  "name" = "${each_vm.name}",
  "id"   = "${each_vm.id}",
  "fqdn" = "${each_vm.fqdn}"
 }])
}

output "VMs_disk" {
  value = toset([for disk_vm in yandex_compute_instance.disk_vm : {
  "name" = "${disk_vm.name}",
  "id"   = "${disk_vm.id}",
  "fqdn" = "${disk_vm.fqdn}"
 }])
}
