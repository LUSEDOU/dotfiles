alias zshconfig="nvim ~/.zshrc"
alias szz="source ~/.zshrc"
alias tzz="tmux source $TMUXCONFIG"
alias aliasconfig="nvim ~/.oh-my-zsh/custom/my_aliases.zsh"
alias pathconfig="nvim ~/.oh-my-zsh/custom/my_paths.zsh"
alias ohmyzsh="nvim ~/.oh-my-zsh"

VIMCONFIG="$HOME/.config/nvim"
alias vimconfig="nvim $VIMCONFIG"

TMUXCONFIG="$HOME/.tmux.conf"
alias tmuxconfig="nvim $TMUXCONFIG"

FLUTTERSDK="$HOME/fvm/default/bin"

BELITECH="$HOME/BELITECH"
BELITY="$BELITECH/belity_app"
alias belity="cd $BELITY"

BELITER="$BELITECH/beliter_app"
alias beliter="cd $BELITER"

ANALYSIS="$BELITECH/analysis"
alias analysis="cd $ANALYSIS"

BACKEND="$BELITECH/backend"
alias backend="cd $BACKEND"

alias ff="fvm flutter $*"
alias ffr="ff run $*"
alias ffa="ff build apk $*"
alias ffad="ffa --debug $*"
