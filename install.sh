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

# ptyxis

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
    eza
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
    ttf-ubuntu-font-family
    inxi
    nerdfetch
    gtk-engine-murrine
    gtk-engines
    gnome-themes-extra
    bat
"

aur_helper(){    
    if [ ! -d "$HOME/.src" ]; then
        mkdir -p "$HOME/.src" && cd "$HOME/.src" && git clone https://aur.archlinux.org/yay-bin && cd yay-bin && makepkg --noconfirm -si        
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
    # curl -sSLo "${HOME}/.config/fastfetch/config.jsonc" https://raw.githubusercontent.com/ChrisTitusTech/mybash/main/config.jsonc
    curl -sSLo "${HOME}/.config/fastfetch/config.jsonc" https://raw.githubusercontent.com/amonetlol/arch_vm/main/fastfetch_ChrisTitus-config.jsonc
    # curl -sSLo "${HOME}/.config/fastfetch/config.jsonc" https://raw.githubusercontent.com/amonetlol/arch_vm/main/fastfetch_config.jsonc
    sudo pacman -S ttf-cousine-nerd --noconfirm

    # set alias
    curl -sSLo "${HOME}/.aliases.sh" https://github.com/amonetlol/arch/raw/refs/heads/main/aliases.sh
    echo 'source ~/.aliases.sh' >> ~/.bashrc

    # set extra
    curl -sSLo "${HOME}/.extra.sh" https://github.com/amonetlol/arch/raw/refs/heads/main/extra.sh
    echo 'source ~/.extra.sh' >> ~/.bashrc

    # autojump
    echo "source /usr/share/autojump/autojump.bash" >> ~/.bashrc

    ## nvim
    # git clone https://github.com/amonetlol/nvim ~/.config/nvim
    # git clone https://github.com/amonetlol/neovim-kickstart-config.git ~/.config/nvim
    # yay -S --needed --noconfirm fd ripgrep lua51 luarocks tree-sitter-cli xclip nodejs python-pynvim npm wl-clipboard ruff python-pip terraform
    git clone https://github.com/amonetlol/nvim_gruvbox.git  ~/.config/nvim
    yay -S --needed --noconfirm fd ripgrep lua51 luarocks tree-sitter-cli xclip nodejs python-pynvim npm wl-clipboard python-pip lazygit fzf lua51-jsregexp
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
    # wget -O ~/.config/starship.toml https://raw.githubusercontent.com/amonetlol/terminal-bash/refs/heads/main/starship-titus.toml
    # setup 3
    wget -O ~/.config/starship.toml https://raw.githubusercontent.com/amonetlol/terminal-bash/refs/heads/main/starship-arch-os.toml
    # sudo cp ~/.config/starship.toml /root/.config/starship.toml

}

update_bash(){
    source ~/.bashrc
}

vm(){
    yay -S --needed --noconfirm open-vm-tools fuse2 gtkmm3
    sudo systemctl enable --now vmtoolsd
}

remove(){
    sudo pacman -R gnome-music epiphany gnome-maps gnome-weather totem gnome-contacts gnome-calendar gnome-clocks simple-scan gnome-software snapshot decibels malcontent --noconfirm
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
    #yay -S --needed --noconfirm chaotic-aur/nordzy-icon-theme-git chaotic-aur/dracula-gtk-theme-git chaotic-aur/bibata-cursor-theme chaotic-aur/colloid-cursors-git chaotic-aur/volantes-cursors
    yay -S --needed --noconfirm jasper-gtk-theme-git chaotic-aur/nordzy-icon-theme-git chaotic-aur/bibata-cursor-theme
}

bye(){
    printf "\n"
    printf "%b\n" "${GREEN}Setup completo!!!${RC}" "\n"
    printf "%b\n" "${CYAN}TODO:${RC}"
    printf "${RED}
    Falta as extensões:${YELLOW}
    App Hider
    Dash to Dock
    Caffeine
    Vitals
    Tray Icons: Reloaded
    Impatience
    Blur my Shell
    
    ${RED}Aparência:${YELLOW}
    Icone: Nordzy-dark
    Cursor: Bibata-Modern-Ice
    Shell: Dracula

    ${RED}Fontes:${YELLOW}
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
