#!/bin/bash

apt update

rm -Rf $HOME/LIVE_BOOT

apt install debootstrap squashfs-tools xorriso grub-pc-bin grub-efi-amd64-bin mtools -y

mkdir $HOME/LIVE_BOOT

debootstrap \
    --arch=amd64 \
    --variant=minbase \
    stable \
    $HOME/LIVE_BOOT/chroot \
    http://ftp.us.debian.org/debian/

while true; do
    read -p "Do you wish to chroot into this environment? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

chroot $HOME/LIVE_BOOT/chroot
