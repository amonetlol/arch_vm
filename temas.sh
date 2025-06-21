#!/bin/sh -e

theme_1(){
echo "Qogir"
    yay -S --needed --noconfirm qogir-gtk-theme qogir-icon-theme gtk-engine-murrine gtk-engines gnome-themes-extra
}

theme_2(){
    echo "Catppuccin-Mocha"
    yay -S --needed --noconfirm catppuccin-gtk-theme-mocha mcmojave-circle-icon-theme-git catppuccin-cursors-mocha gtk-engine-murrine gtk-engines gnome-themes-extra    
}

# mcmuse-circle-git

theme_1
theme_2
