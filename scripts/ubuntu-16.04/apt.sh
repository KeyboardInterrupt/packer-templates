#!/bin/bash

set -e
set -x

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo systemctl reboot
