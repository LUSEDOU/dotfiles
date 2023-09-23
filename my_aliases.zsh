alias zshconfig="nvim ~/.zshrc"
alias szz="source ~/.zshrc"
alias aliasconfig="nvim ~/.oh-my-zsh/custom/my_aliases.zsh"
alias pathconfig="nvim ~/.oh-my-zsh/custom/my_paths.zsh"
alias ohmyzsh="nvim ~/.oh-my-zsh"

VIMCONFIG="$HOME/.config/nvim"
alias vimconfig="nvim $VIMCONFIG"

TMUXCONFIG="$HOME/.config/tmux/tmux.conf"
alias tmuxconfig="nvim $TMUXCONFIG"

FLUTTERSDK="$HOME/fvm/default/bin"

BELITECH="$HOME/BELITECH"
BELITY="$BELITECH/belity_app"
alias belity="cd $BELITY"

BELITER="$BELITECH/beliter_app"
alias beliter="cd $BELITER"

alias ff="fvm flutter $*"
alias ffr="ff run $*"
alias ffa="ff build apk $*"
alias ffad="ffa --debug $*"
