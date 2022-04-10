#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
while pgrep -a apt; do echo 'Waiting for apt...'; sleep 1; done
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma