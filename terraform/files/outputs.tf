output "external_ip_address_alb" {
  value = yandex_alb_load_balancer.reddit-load-balancer.listener.0.endpoint.0.address.0.external_ipv4_address
}
