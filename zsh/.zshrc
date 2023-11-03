export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    history
    emoji
    encode64
    zsh-autosuggestions
    web-search
    dirhistory
    zsh-syntax-highlighting
    fast-syntax-highlighting
)

export ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

setopt interactivecomments # Activate bash style comments

bindkey -v # Use vim keybindings in zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($HOME'/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f $HOME"/miniconda3/etc/profile.d/conda.sh" ]; then
        . $HOME"/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH=$HOME"/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


eval "$(starship init zsh)"

neofetch

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
