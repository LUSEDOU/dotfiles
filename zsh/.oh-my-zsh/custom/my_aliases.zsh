DOTFILES="$HOME/dotfiles"
alias dotfiles="cd $DOTFILES && nvim ."

PERSONAL="$DOTFILES/personal"

ZSHCONFIG="$DOTFILES/zsh/.oh-my-zsh/custom"

alias zshconfig="nvim ~/.zshrc"
alias szz="source ~/.zshrc"
alias tzz="tmux source $TMUXCONFIG"
alias aliasconfig="nvim $ZSHCONFIG/my_aliases.zsh"
alias pathconfig="nvim $ZSHCONFIG/my_paths.zsh"
alias ohmyzsh="nvim ~/.oh-my-zsh"

VIMCONFIG="$DOTFILES/nvim/.config/nvim"
alias vimconfig="cd $VIMCONFIG && nvim ."

TMUXCONFIG="$HOME/.tmux.conf"
alias tmuxconfig="nvim $TMUXCONFIG"

# alias binconfig="cd $DOTFILES/bin && nvim ."

# FDK="$HOME/fvm/default/bin"
#
# BELITECH="$HOME/BELITECH"
# alias belitech="cd $BELITECH"
#
# BELITY="$BELITECH/belity_app"
# alias belity="cd $BELITY"
#
# BELITER="$BELITECH/beliter_app"
# alias beliter="cd $BELITER"
#
# BACKEND="$BELITECH/backend"
# alias backend="cd $BACKEND"
#
# ANALYSIS="$BELITECH/analysis"
# alias analysis="cd $ANALYSIS"

# alias ff="fvm flutter $*"
# alias ffr="ff run $*"
# alias ffg="ff pub get $*"
# alias ffa="ff build apk $*"
# alias ffad="ffa --debug $*"

# alias dd="fvm dart $*"
# alias ddg="dd pub get $*"

alias t="tree -L 2"
alias ls="exa -T -L 1 --git --icons"
alias lg="lazygit"
# unalias github
#
mkcd() {
    mkdir -p "$1" && cd "$1"
}

n ()
{
    export VISUAL=ewrap
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

unalias gg
# Clone a git repository to a given directory
gg() {
    local host="github.com"

    if ! command -v git &>/dev/null; then
        echo "git not found"
        return
    fi

    if [ $# -eq 0 ]; then
        echo "Usage: gg <user>/<repo> [dir]"
        return
    fi


    local subdir="projects"
    if [ $# -eq 2 ]; then
        subdir="$2"
    fi

    local repo_url="ssh://git@$host/$1.git"
    # local dir="$HOME/projects/$2/${1##*/}"
    local dir="$HOME/$subdir/${1##*/}"

    if [ -d "$dir" ]; then
        echo "$dir already exists"
        return
    fi

    git clone "$repo_url" "$dir"
}

fcd() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/projects ~/dotfiles ~ -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
        return
    fi

    echo $selected
    cd "$selected"
}

alias vim="nvim"
alias todo="glow $PERSONAL/TODO.md -p"

export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG="p:preview-tui;o:xdg-open"
