export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    history
    emoji
    encode64
    zsh-autosuggestions
    # web-search
    dirhistory
    # zsh-syntax-highlighting
    fast-syntax-highlighting
)

export ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

setopt interactivecomments # Activate bash style comments

bindkey -v # Use vim keybindings in zsh
# bindkey "^F" "/Users/lusedou/.local/bin/scripts/tmux-sessionizer"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lusedou/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lusedou/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/lusedou/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lusedou/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/lusedou/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/lusedou/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


eval "$(starship init zsh)"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/lusedou/.dart-cli-completion/zsh-config.zsh ]] && . /Users/lusedou/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
# export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# opam configuration
[[ ! -r /home/lusedou/.opam/opam-init/init.zsh ]] || source /home/lusedou/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/lusedou/conda/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/lusedou/conda';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
