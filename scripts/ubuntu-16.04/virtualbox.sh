#!/bin/bash

set -e
set -x

if [ "$PACKER_BUILDER_TYPE" != "virtualbox-iso" ]; then
  exit 0
fi

sudo apt-get -y install dkms make

# Uncomment this if you want to install Guest Additions with support for X
#sudo apt-get -y install xserver-xorg

sudo mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
sudo /mnt/VBoxLinuxAdditions.run || :
sudo umount /mnt/
rm -f ~/VBoxGuestAdditions.iso

sudo sh -c 'echo "vboxguest" >> /etc/modules-load.d/vbox'
sudo sh -c 'echo "vboxsf" >> /etc/modules-load.d/vbox'
sudo sh -c 'echo "vboxvideo" >> /etc/modules-load.d/vbox'

VBOX_VERSION=$(cat ~/.vbox_version)
if [ "$VBOX_VERSION" == '4.3.10' ]; then
  # https://www.virtualbox.org/ticket/12879
  sudo ln -s "/opt/VBoxGuestAdditions-$VBOX_VERSION/lib/VBoxGuestAdditions" /usr/lib/VBoxGuestAdditions
fi
