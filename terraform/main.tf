terraform {
  required_providers {
    yandex = {
      # source = "yandex-cloud/yandex"
      version = "~>0.35"
    }
  }
  required_version = "~> 0.12"
}

provider "yandex" {
  service_account_key_file = "secrets/key.json"
  cloud_id = "b1gkqjl0oe48651f5mjj"
  folder_id = "b1gqp7711qhgjtc9l0mi"
  zone = "ru-central1-a"
}

# data "yandex_compute_image"

resource "yandex_compute_instance" "reddit-app" {
  name = "reddit-app"
  hostname = "reddit-app"
  resources {
    cores = 2
    memory = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd83mfr8osk59okkaslo"
    }
  }
  network_interface {
    subnet_id = "e9bkt8p86vv20gmjvos4"
    nat = true
    nat_ip_address = "51.250.82.15"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/ubuntu.pub")}"
  }
}