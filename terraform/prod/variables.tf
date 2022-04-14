variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable service_account_key_file {
  description = "key.json"
}
variable app_image_id {
  description = "Application disk image id"
}
variable db_image_id {
  description = "Database disk image id"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable connection_private_key_path {
  description = "Private key for provisioners"
}