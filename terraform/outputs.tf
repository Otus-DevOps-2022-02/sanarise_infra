output "app_subnet_id" {
  value = yandex_vpc_subnet.app-subnet.id
}
output "external_ip_address_app" {
  value = yandex_compute_instance.app.*.network_interface.0.nat_ip_address
}
output "external_ip_address_db" {
  value = yandex_compute_instance.db.*.network_interface.0.nat_ip_address
}
