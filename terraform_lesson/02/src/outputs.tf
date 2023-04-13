output "instance_external_ip_1" {
  value = "${yandex_compute_instance.platform.network_interface.0.nat_ip_address}"
}
output "instance_external_ip_2" {
  value = "${yandex_compute_instance.platform_db.network_interface.0.nat_ip_address}"
}
