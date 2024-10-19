#!/bin/sh -e

# comentário aqui

RC='\033[0m'
RED='\033[31m'
YELLOW='\033[33m'
CYAN='\033[36m'
GREEN='\033[32m'

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
    inxi
    nerdfetch
    gtk-engine-murrine
    gtk-engines
    gnome-themes-extra
    bat
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
    yay -S --needed --noconfirm luarocks tree-sitter-cli xclip nodejs python-pynvim npm wl-clipboard
    rm -rf ~/.config/nvim/.git
    rm -rf ~/.config/nvim/.gitignore

    ## Scripts
    mkdir -p "${HOME}/Scripts"
    curl -sSLo "${HOME}/Scripts/fsearch" https://github.com/amonetlol/terminal-bash/raw/refs/heads/main/fsearch
    chmod +x "${HOME}/Scripts/fsearch"

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
    yay -S --needed --noconfirm open-vm-tools fuse2 gtkmm3
    sudo systemctl enable --now vmtoolsd
}

remove(){
    sudo pacman -R gnome-music epiphany gnome-maps gnome-weather totem gnome-contacts gnome-calendar gnome-clocks simple-scan gnome-software snapshot --noconfirm
    #gnome-shell-extensions
}

chaotic(){
    # Adicionar a chave do repositório
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB

    # Adicionar a lista de mirrors do Chaotic-AUR
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    # Adicionar o repositório Chaotic-AUR ao pacman.conf
    echo "[chaotic-aur]" | sudo tee -a /etc/pacman.conf
    echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf

    # Atualizar e instalar pacotes do Chaotic-AUR
    sudo pacman -Syu --noconfirm

    # add temas e icones
    yay -S --needed --noconfirm chaotic-aur/nordzy-icon-theme-git chaotic-aur/dracula-gtk-theme-git chaotic-aur/bibata-cursor-theme chaotic-aur/colloid-cursors-git chaotic-aur/volantes-cursors
}

bye(){
    printf "\n"
    printf "%b\n" "${GREEN}Setup completo!!!${RC}" "\n"
    printf "%b\n" "${CYAN}TODO:${RC}"
    printf "%b\n" "${YELLOW}
    Falta as extensões:
    App Hider
    Dash to Dock
    Caffeine
    Vitals
    Tray Icons: Reloaded
    Imparience    
    
    Aparência:
    Icone: Nordzy-dark
    Cursor: Bibata-Modern-Ice
    Shell: Dracula

    Fontes:
    Interface e documento: Poppins Regular x2
    Monoespaçado: Meslo NF Mono Regular${RC}"
}

# função
pre_install
aur_helper
install
config
vm
remove
update_bash
chaotic
bye
