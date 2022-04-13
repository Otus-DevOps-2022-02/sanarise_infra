terraform {
  required_providers {
    yandex = "~> 0.35"
  }
  required_version = "~> 0.12.0"
}

provider "yandex" {
  version                  = "~> 0.35"
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source = "./modules/vpc"
  zone   = var.zone
}

module "app" {
  source                      = "./modules/app"
  zone                        = var.zone
  subnet_id                   = module.vpc.app_subnet_id
  app_image_id                = var.app_image_id
  public_key_path             = var.public_key_path
  connection_private_key_path = var.connection_private_key_path
}

module "db" {
  source          = "./modules/db"
  zone            = var.zone
  subnet_id       = module.vpc.app_subnet_id
  db_image_id     = var.db_image_id
  public_key_path = var.public_key_path
}
