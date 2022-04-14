resource "yandex_alb_load_balancer" "reddit-load-balancer" {
  name = "reddit-load-balancer"

  network_id = "enpsj80j6uu4ouip1ogd"

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = var.subnet_id
    }
  }

  listener {
    name = "reddit-listener"
    endpoint {
      address {
        external_ipv4_address {
          address = "51.250.64.127"
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.reddit-router.id
      }
    }
  }
}

resource "yandex_alb_http_router" "reddit-router" {
  name = "reddit-http-router"
}

resource "yandex_alb_virtual_host" "reddit-virtual-host" {
  name           = "reddit-virtual-host"
  http_router_id = yandex_alb_http_router.reddit-router.id
  route {
    name = "reddit-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.reddit-backend-group.id
        timeout          = "3s"
      }
    }
  }
}

resource "yandex_alb_backend_group" "reddit-backend-group" {
  name = "reddit-backend-group"

  http_backend {
    name             = "reddit-http-backend"
    weight           = 1
    port             = 9292
    target_group_ids = yandex_alb_target_group.reddit-target-group.*.id
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_target_group" "reddit-target-group" {
  name = "reddit-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance.reddit-app.*.network_interface.0.ip_address
    content {
      subnet_id  = var.subnet_id
      ip_address = target.value
    }
  }
}
