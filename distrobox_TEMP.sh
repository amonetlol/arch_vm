sudo pacman -S docker
sudo systemctl enable --now docker.service

sudo usermod -aG docker $USER

#verificar se esta funcionando:
docker run hello-world


sudo pacman -S flatpak distrobox
flatpak install flathub io.github.dvlv.boxbuddyrs
