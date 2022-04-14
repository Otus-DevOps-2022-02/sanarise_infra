resource "yandex_compute_instance" "db" {
  count    = var.reddit-db-count
  name     = "reddit-db-${count.index}"
  hostname = "reddit-db-${count.index}"
  zone     = var.zone
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.db_image_id
    }
  }
  network_interface {
    subnet_id      = var.subnet_id
    nat            = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}