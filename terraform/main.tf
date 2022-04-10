terraform {
  required_providers {
    yandex = "~>0.35"
  }
  required_version = "~> 0.12"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

# data "yandex_compute_image"

resource "yandex_compute_instance" "reddit-app" {
  count    = var.reddit-app-count
  name     = "reddit-app-${count.index}"
  hostname = "reddit-app-${count.index}"
  zone     = var.app_instance_zone
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  network_interface {
    subnet_id      = var.subnet_id
    nat            = true
    # nat_ip_address = "51.250.82.15"
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.connection_private_key_path)
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}