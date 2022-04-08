#!/bin/bash
yc compute instance create \
  --name reddit-full \
  --hostname reddit-full \
  --memory=4 \
  --cores=2 \
  --core-fraction=20 \
  --zone=ru-central1-a \
  --create-boot-disk image-name=reddit-full-1649323996 \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4,nat-address=51.250.80.31 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub
