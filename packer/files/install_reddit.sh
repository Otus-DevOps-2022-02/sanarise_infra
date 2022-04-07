#!/bin/bash
sudo apt-get update
while pgrep -a apt-get; do echo 'Waiting for apt-get...'; sleep 1; done
sudo apt-get install -y git
cd
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

echo '[Unit]
Description=Puma service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/reddit
ExecStart=/usr/local/bin/puma

[Install]
WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/puma.service

sudo systemctl start puma
sudo systemctl enable puma
