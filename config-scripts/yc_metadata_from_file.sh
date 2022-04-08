#!/bin/bash
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --cores=2 \
  --core-fraction=20 \
  --zone=ru-central1-a \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4,nat-address=51.250.71.229 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./metadata.yaml

#yc compute instance remove-one-to-one-nat reddit-app --network-interface-index 0
#yc compute instance add-one-to-one-nat reddit-app --network-interface-index 0 --nat-address 51.250.71.229 --nat-ip-version ipv4 --internal-address 10.128.0.5
