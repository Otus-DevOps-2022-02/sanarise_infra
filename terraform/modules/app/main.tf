resource "yandex_compute_instance" "app" {
  count    = var.reddit-app-count
  name     = "reddit-app-${count.index}"
  hostname = "reddit-app-${count.index}"
  zone     = var.zone
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.app_image_id
    }
  }
  network_interface {
    subnet_id      = var.subnet_id
    nat            = true
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
#   provisioner "file" {
#     source      = "files/puma.service"
#     destination = "/tmp/puma.service"
#   }
#   provisioner "remote-exec" {
#     script = "files/deploy.sh"
#   }
}