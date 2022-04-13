variable reddit-app-count {
  default = "1"
}
variable zone {
  description = "Zone"
}
variable subnet_id {
  description = "Subnet id"
}
variable app_image_id {
  description = "Application disk image id"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable connection_private_key_path {
  description = "Private key for provisioners"
}