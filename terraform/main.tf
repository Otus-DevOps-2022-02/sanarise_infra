terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      vversion = "~>0.35"
    }
  }
  required_version = "~> 0.12"
}

provider "yandex" {
  token     = "AQAAAAAB0Zp8AATuwainFJr0tkI_lel5OmQqcQI"
  cloud_id  = "b1gkqjl0oe48651f5mjj"
  folder_id = "b1gqp7711qhgjtc9l0mi"
  zone      = "ru-central1-a"
}