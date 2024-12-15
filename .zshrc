ZSH_THEME="robbyrussell"
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export LANG=C

plugins=(git docker)

source $ZSH/oh-my-zsh.sh
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# alias
alias a='alias'
alias g='git'
alias k='kubectl'
alias v='nvim'

alias vz='v ~/.zshrc'
alias sz='source ~/.zshrc'
alias vf='v $(fzf)'

alias vim='nvim'

alias python='python3'

# git alias
alias gs='git status'

# Increment Search
bindkey -v
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
export SAVEHIST=100000

