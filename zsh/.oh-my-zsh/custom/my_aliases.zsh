alias zshconfig="nvim ~/.zshrc"
alias szz="source ~/.zshrc"
alias tzz="tmux source $TMUXCONFIG"
alias aliasconfig="nvim ~/.oh-my-zsh/custom/my_aliases.zsh"
alias pathconfig="nvim ~/.oh-my-zsh/custom/my_paths.zsh"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias dotfiles="cd ~/dotfiles && nvim ."

VIMCONFIG="$HOME/.config/nvim"
alias vimconfig="cd $VIMCONFIG && nvim ."

TMUXCONFIG="$HOME/.tmux.conf"
alias tmuxconfig="nvim $TMUXCONFIG"

FDK="$HOME/fvm/default/bin"

BELITECH="$HOME/BELITECH"
alias belitech="cd $BELITECH"

BELITY="$BELITECH/belity_app"
alias belity="cd $BELITY"

BELITER="$BELITECH/beliter_app"
alias beliter="cd $BELITER"

BACKEND="$BELITECH/backend"
alias backend="cd $BACKEND"

ANALYSIS="$BELITECH/analysis"
alias analysis="cd $ANALYSIS"

alias ff="fvm flutter $*"
alias ffr="ff run $*"
alias ffg="ff pub get $*"
alias ffa="ff build apk $*"
alias ffad="ffa --debug $*"

alias t="tree -L 2"
