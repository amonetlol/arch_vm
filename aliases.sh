alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ping='ping -c 10'
alias exe='chmod +x'
alias ft='fastfetch'
alias grep='grep -i'

alias al='nvim ~/.bashrc ~/.aliases.sh'
alias .r='source ~/.bashrc'
alias up2='yay -Syyu --noconfirm'
alias yay='yay --noconfirm'
alias yin='yay --noconfirm -S'
alias yse='yay -Ss'
alias ysel='yay -Qq | grep'
alias yre='yay --noconfirm -R'
alias yinfo='yay -Si'
alias rpac='sudo reflector --country Brazil --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias orf='sudo pacman -Qtdq | sudo pacman -Rns -'
alias cls='sudo pacman -Scc && yay -Sc'
alias man='tldr'
alias nv='nvim'
alias df='duf -hide special'
alias duf='duf -hide special'
alias ff='sh ~/Scripts/fsearch'
alias hg='history | grep'
alias ag='alias | grep'
alias j-edit='nv ~/.local/share/autojump/autojump.txt'
alias inxi='inxi -Fxz'
alias fv='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs -r nvim'
alias nf='nerdfetch'

# --- ls --- #
alias lg="ls | grep"
alias ls='exa -lah --color=always --group-directories-first --icons'
alias ll='exa -lah --color=always --group-directories-first --icons'
alias lr='exa -R --color=always --icons --oneline'
alias lrv1='exa -R --color=always --icons --oneline --level=1'
alias lrv2='exa -R --color=always --icons --oneline --level=2'
alias ld='exa -lah --color=always --group-directories-first --icons --sort mod' # sort by date/time
alias tree='exa --tree --icons --group-directories-first'
#alias lt="command ls -l | awk 'NR>1 {print $9}'"
lt() {
  command ls -l | awk 'NR>1 {print $9}'
  #command exa -l --color=always --group-directories-first --icons | awk '{print $7, $8, $9}'
}

alias tx='gnome-text-editor'

# cd into the old directory
alias bd='cd "$OLDPWD"'
