
###
# Setup Path
###
export GOPATH=$HOME/go
PATH=$HOME/bin:/usr/local/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.local/bin:/usr/local/sbin:/miniconda3/bin:$PATH
setopt auto_cd
export PATH
cdpath=(. $HOME $HOME/projects)

###
# Zsh Configuration
###

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yyyy"
plugins=(asdf git-open zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
source $ZSH/oh-my-zsh.sh

GIT_PROMPT_EXECUTABLE="haskell"
ZSH_THEME_GIT_PROMPT_CACHE=''
source ~/zsh/zsh-git-prompt/zshrc.sh

###
# Set Environment Variables
###
export DOKKU_PORT='10044'
export TERM="xterm-256color"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

###
# Aliases
###

alias bx='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias ngrok='$HOME/ngrok'
alias til='vim ~/.today-i-learned'
alias gs='git status'
alias git_review='ruby ~/projects/git_review.rb -f day -e tom@discolabs.com -p /Users/tomgamon/projects/'
alias setup_rubocop='curl -s https://gist.githubusercontent.com/zero51/2411f0fc8cdaaace1e8e4844aea3effc/raw/ > .rubocop.yml'
alias 999='bx rubocop -a'
alias gco='git checkout'
alias start='git flow feature start'
alias bump='~/projects/bash/bump_version.sh'
alias rg='rg --no-ignore-messages'
alias setup_overcommit='curl -s https://gist.githubusercontent.com/zero51/b94b7c2e134de4be9dc9e3966d8708e8/raw/ > .overcommit.yml'
alias gp='git pull'
alias dcr='docker-compose run --rm'
alias dcra='docker-compose run --rm app'
alias dcrw='docker-compose run --rm web'
alias ngrokc='ngrok `< .ngrok-config`'
alias zc='vim ~/.zshrc'
alias vc='vim ~/.vimrc'
alias note="vim $(date +"~/notes/%d_%m_%Y.md") -c 'cd ~/notes/.'" 
alias vim="nvim"
alias ovim='vim'
alias fvim='vim $(ls|fzf)'

###
# Custom Functions
###

# Check presence of docker file
detect-docker() if [ -d .git ]; then
  if [ -e "$(git rev-parse --show-toplevel)/docker-compose.yml" ]; then 
    export DOCKER_REPO=true
  else
    export DOCKER_REPO=false
  fi
fi

show-ship() if [ "$DOCKER_REPO" = true ] ; then
  echo '🚢'
fi

dc() { if [[ $@ == "up!" ]]; then command bundle install && dc build && dc up; else command  docker-compose "$@"; fi; }

cd!() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

###
# Prompt
###

precmd() { detect-docker; print -rP "$(show-ship)$(git_super_status)" }
PROMPT='> %B%2~%b $ '

###
# Integrations
###

# Iterm 2 Shell Integration
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Bring in tmuxinator
source ~/zsh/tmuxinator.zsh

# Set fzf command to use rg
export FZF_DEFAULT_COMMAND='rg --files --smart-case --hidden --no-ignore-vcs'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


###
# Bring in any local configuration
###
source $HOME/.zsh-local

