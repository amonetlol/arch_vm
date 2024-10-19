#!/bin/sh -e

# comentário aqui

pre_install(){
    echo 'MAKEFLAGS="-j$(nproc)"' | sudo tee -a /etc/makepkg.conf
}

packages="
    fastfetch
    curl 
    neovim
    wget 
    starship 
    bash-completion 
    ripgrep 
    gnome-tweaks 
    extension-manager 
    btop 
    htop
    google-chrome
    firefox
    exa
    duf
    tldr
    reflector
    rsync
    fd
    fzf
    autojump
    ttf-cascadia-code-nerd
    ttf-firacode-nerd
    ttf-hack-nerd
    ttf-poppins
    ttf-roboto
    ttf-meslo-nerd

"

aur_helper(){    
    if [ ! -d "$HOME/.src" ]; then
        mkdir -p "$HOME/.src"        
    else
        cd "$HOME/.src" && git clone https://aur.archlinux.org/yay-bin && cd yay-bin && makepkg --noconfirm -si
    fi  
    
}

install(){
    yay -S --needed --noconfirm $packages
}

config(){
    # fastfetch
    mkdir -p "${HOME}/.config/fastfetch/"
    curl -sSLo "${HOME}/.config/fastfetch/config.jsonc" https://raw.githubusercontent.com/ChrisTitusTech/mybash/main/config.jsonc   

    # set alias
    curl -sSLo "${HOME}/.aliases.sh" https://github.com/amonetlol/arch/raw/refs/heads/main/aliases.sh
    echo 'source ~/.aliases.sh' >> ~/.bashrc

    # set extra
    curl -sSLo "${HOME}/.extra.sh" https://github.com/amonetlol/arch/raw/refs/heads/main/extra.sh
    echo 'source ~/.extra.sh' >> ~/.bashrc

    # autojump
    echo "source /usr/share/autojump/autojump.bash" >> ~/.bashrc

    ## nvim
    git clone https://github.com/amonetlol/nvim ~/.config/nvim    
    yay -S --needed --noconfirm luarocks tree-sitter-cli xclip nodejs python-pynvim npm
    rm -rf ~/.config/nvim/.git
    rm -rf ~/.config/nvim/.gitignore

    ## Scripts
    mkdir -p "${HOME}/Scripts"
    curl -sSLo "${HOME}/Scripts/fsearch" https://github.com/amonetlol/terminal-bash/raw/refs/heads/main/fsearch
    chmod +x "${HOME}/Scripts/fsearch"

    ## Gnome Extensions
    mkdir -p /tmp/temp
    wget https://extensions.gnome.org/extension-data/app-hider@gnome-extensions.org -O /tmp/temp/app-hider@gnome-extensions.org
    wget https://extensions.gnome.org/extension-data/dash-to-dock@gnome-extensions.org -O /tmp/temp/dash-to-dock@gnome-extensions.org
    gnome-extensions install /tmp/temp/app-hider@gnome-extensions.org
    gnome-extensions install /tmp/temp/dash-to-dock@gnome-extensions.org
    gnome-extensions enable app-hider@gnome-extensions.org
    gnome-extensions enable dash-to-dock@gnome-extensions.org
    rm -rf /tmp/temp

    ## fonts
    fc-cache -vf

    # starship
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    # setup 1
    # wget -O ~/.config/starship.toml https://raw.githubusercontent.com/amonetlol/terminal-bash/refs/heads/main/starship.toml
    # setup 2
    wget -O ~/.config/starship.toml https://raw.githubusercontent.com/amonetlol/terminal-bash/refs/heads/main/starship-titus.toml

}

update_bash(){
    source ~/.bashrc
}

vm(){
    yay -S --needed --noconfirm open-vm-tools fuse2 gtkmn3
    sudo systemctl enable --now vmtoolsd
}

theme(){
    yay -S --needed --noconfirm qogir-gtk-theme qogir-icon-theme
}

remove(){
    sudo pacman -R gnome-music cheese epiphany gnome-maps gnome-weather totem gnome-contacts gnome-calendar gnome-clocks simple-scan gnome-photos gnome-software snapshot
    #gnome-shell-extensions
}

bye(){
    echo "Setup completo"
}

# função
pre_install
aur_helper
install
config
vm
theme
remove
update_bash
bye
