terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "otus-terraform-state"
    region     = "ru-central1-a"
    key        = "prod/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}