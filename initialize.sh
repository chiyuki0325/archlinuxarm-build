#!/bin/bash
echo "[archlinuxcn]" >> /etc/pacman.conf
echo "Server = https://repo.archlinuxcn.org/aarch64" >> /etc/pacman.conf
pacman-key --init
pacman-key --populate archlinuxarm
pacman-key --lsign-key "farseerfc@archlinux.org"
pacman -Syu archlinux-keyring archlinuxarm-keyring archlinuxcn-keyring
pacman -Syu --noconfirm yay

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
