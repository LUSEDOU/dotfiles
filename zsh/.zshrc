export EDITOR="vim"
export VISUAL="vim"
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
export DISABLE_MAGIC_FUNCTIONS=true
export DISABLE_AUTO_UPDATE="true"


source $ZSH/oh-my-zsh.sh

setopt interactivecomments # Activate bash style comments

bindkey -v # Use vim keybindings in zsh
# bindkey "^F" tmux-sessionizer

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


eval "$(starship init zsh)"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# opam configuration
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
# export MAMBA_EXE='${HOME}/conda/bin/mamba';
# export MAMBA_ROOT_PREFIX='${HOME}/conda';
# __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__mamba_setup"
# else
#     alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
# fi
# unset __mamba_setup
# <<< mamba initialize <<<

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f ${HOME}/.dart-cli-completion/zsh-config.zsh ]] && . ${HOME}/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# The next line updates PATH for the Google Cloud SDK.
if [ -f '${HOME}/belity/gl/google-cloud-sdk/path.zsh.inc' ]; then . '${HOME}/belity/gl/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '${HOME}/belity/gl/google-cloud-sdk/completion.zsh.inc' ]; then . '${HOME}/belity/gl/google-cloud-sdk/completion.zsh.inc'; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
