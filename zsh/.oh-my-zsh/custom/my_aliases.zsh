alias zshconfig="nvim ~/.zshrc"
alias szz="source ~/.zshrc"
alias tzz="tmux source $TMUXCONFIG"
alias aliasconfig="nvim ~/.oh-my-zsh/custom/my_aliases.zsh"
alias pathconfig="nvim ~/.oh-my-zsh/custom/my_paths.zsh"
alias ohmyzsh="nvim ~/.oh-my-zsh"

DOTFILES="$HOME/dotfiles"
alias dotfiles="cd $DOTFILES && nvim ."

VIMCONFIG="$DOTFILES/nvim/.config/nvim"
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

alias dd="fvm dart $*"

alias t="tree -L 2"
alias lg="lazygit"
# unalias github

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -e "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
