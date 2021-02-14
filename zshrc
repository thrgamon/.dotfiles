setopt extendedglob local_options
. /usr/local/opt/asdf/asdf.sh

###
# Setup Path
###
export GOPATH=$HOME/go
PATH=$HOME/bin:/usr/local/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.local/bin:/usr/local/sbin:/miniconda3/bin:$PATH
setopt auto_cd
export PATH
export ERL_AFLAGS="-kernel shell_history enabled"
cdpath=(. $HOME $HOME/projects)

###
# Zsh Configuration
###

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yyyy"
plugins=(git-open zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
source $ZSH/oh-my-zsh.sh

# GIT_PROMPT_EXECUTABLE="haskell"
# ZSH_THEME_GIT_PROMPT_CACHE=''
# source ~/zsh/zsh-git-prompt/zshrc.sh

###
# Set Environment Variables
###
export EDITOR='nvim'
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
alias til='nvim ~/Dropbox/notes/today-i-learned.md'
alias gs='git status -sb'
alias ga='git add'
alias gp='git pull'
alias gpu='git push'
alias gc='git commit'
alias pro='gh pr view -w'
alias prs='gh pr status'
alias git_review='ruby ~/projects/git_review.rb -f day -e tom@discolabs.com -p /Users/tomgamon/projects/'
alias setup_rubocop='curl -s https://gist.githubusercontent.com/zero51/2411f0fc8cdaaace1e8e4844aea3effc/raw/ > .rubocop.yml'
alias 999='bx rubocop -a'
alias gco='git checkout'
alias bump='~/projects/bash/bump_version.sh'
alias rg='rg --no-ignore-messages'
alias dcr='docker-compose run --rm'
alias dcra='docker-compose run --rm app'
alias zc='nvim ~/.zshrc'
alias szc='source ~/.zshrc'
alias zcl='nvim ~/.zsh-local'
alias note="nvim $(date +"~/Dropbox/notes/journal/%Y-%m-%d.md") -c 'cd ~/Dropbox/notes/.'" 
alias ssh=color-ssh
alias lint='bx standardrb --fix $(git files | grep -E ".*(.rb)$")'
alias spec='bin/rspec $(git files | grep -E ".*(spec.rb)$")'
alias dump_schema='bundle exec rake graphql:dump_schema'
alias api='cd /Users/tom.gamon/development/cultureamp/performance-api'
alias ui='cd /Users/tom.gamon/development/cultureamp/performance-ui'
alias vim='nvim'
alias vgf='vim $(git files | fzf)'
alias vf='vim $(fzf)'

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

 # http://bryangilbert.com/post/etc/term/dynamic-ssh-terminal-background-colors/
compdef _ssh color-ssh=ssh

color-ssh() {
    trap "~/.dotfiles/colorterm.sh" INT EXIT
    if [[ "$*" =~ "prod" ]]; then
        ~/.dotfiles/colorterm.sh prod
    elif [[ "$*" =~ "staging" ]]; then
        ~/.dotfiles/colorterm.sh dev
    else
        ~/.dotfiles/colorterm.sh prod
    fi
    'ssh' $*
  }

add() {
  local filepath
  filepath=$(date +"$HOME/Dropbox/notes/journal/%Y-%m-%d.md")
  echo "\n---" >> $filepath
  echo "**$@**\n\n" >> $filepath
  nvim $filepath -c 'cd $HOME/Dropbox/notes/.' +
}

rollover() {
  cat $(date -v -1d +"$HOME/Dropbox/notes/journal/%Y-%m-%d.md") | rg "\- \[ \]" >> $(date +"$HOME/Dropbox/notes/journal/%Y-%m-%d.md")
  sed -i .bak 's/\- \[ \]/\- \[\-\]/' $(date -v -1d +"$HOME/Dropbox/notes/journal/%Y-%m-%d.md")
  find "$HOME/Dropbox/notes/journal/*.bak" -type f -delete &>/dev/null 
}

extract () {
  rg $@ --only-matching --no-filename --no-line-number | awk NF
}

gho () {
  pro || git open
}

###
# Prompt
###

PROMPT='> %B%2~%b $ '

###
# Integrations
###

# Iterm 2 Shell Integration
# export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Bring in tmuxinator
# source ~/zsh/tmuxinator.zsh

# Set fzf command to use rg
export FZF_DEFAULT_COMMAND='rg --files --smart-case --hidden --no-ignore-vcs'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


###
# Bring in any local configuration
###
source $HOME/.zsh-local

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
