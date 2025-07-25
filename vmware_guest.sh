#!/bin/sh

sudo pacman -S --needed --noconfirm open-vm-tools fuse2 gtkmm3
sudo systemctl enable --now vmtoolsd

printf "\n Feito!"
