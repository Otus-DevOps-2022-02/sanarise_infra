#!/bin/bash
while pgrep -a apt-get; do echo 'Waiting for apt-get...'; sleep 1; done
sudo apt-get update
while pgrep -a apt-get; do echo 'Waiting for apt-get...'; sleep 1; done
sudo apt-get install -y ruby-full ruby-bundler build-essential
