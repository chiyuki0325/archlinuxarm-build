#!/bin/bash
sed -i 's/^SigLevel.*/SigLevel = Never/' /etc/pacman.conf
sed -i 's/^LocalFileSigLevel.*/LocalFileSigLevel = Never/' /etc/pacman.conf
sed -i 's/^#RemoteFileSigLevel.*/RemoteFileSigLevel = Never/' /etc/pacman.conf
cat << EOM >> /etc/pacman.conf
[archlinuxcn]
Server = https://repo.archlinuxcn.org/aarch64
SigLevel = Never
EOM
# pacman-key --init
# pacman-key --populate archlinuxarm
# pacman-key --lsign-key "farseerfc@archlinux.org"
# pacman -Syu archlinux-keyring archlinuxarm-keyring archlinuxcn-keyring
pacman -Syu --noconfirm base-devel git python yay

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
