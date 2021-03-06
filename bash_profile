source ~/.git-completion.sh
source ~/.git-prompt.sh

export PATH="$PATH:/usr/local/bin"
export SHELL="/usr/local/bin/bash"
export BUNDLE_JOBS=4

export RUSTPATH="$HOME/.cargo/bin"
export PATH=$PATH:$RUSTPATH

export EDITOR=nvim

# aliases
alias ctag='/usr/local/Cellar/ctags/5.8_1/bin/ctags -R --exclude=.git --exclude=log *'
alias volmer='bundle exec rubocop $(git diff-files --name-only -0)'
alias be='bundle exec'
alias fzfp="fzf --preview 'head -100 {}'"
alias fzfv='vi $(fzfp)'
alias git_recent_branches='git branch --sort=-committerdate | head -n 10'
alias git_clean_branches='git branch --merged | ack --invert-match "\*|master" | xargs git branch -d'
alias git_fzf='git show $(git log --pretty=oneline | fzf | cut -d" " -f1)'
alias git_cor='git co $(git_recent_branches | fzf)'
alias git_ste='vi $(git status -s | fzf -m)'
alias crypto_price='coinmon -c cad'
alias serve='ruby -run -e httpd . -p 9090'
alias venv='source ./virtualenv/bin/activate'
alias runtest='bundle exec ruby -I ./test'
alias clear-elasticsearch='curl -X DELETE "http://localhost:9200/*/"'
alias kill-railgun='railgun status -a | tail -n +2 | cut -d " " -f1 | xargs -n 1 railgun stop'
alias clear-yarn="ruby -r json -r fileutils -e \"JSON.parse(File.read('config/npm_packages.json')).each { |dir| FileUtils.rm_rf(dir + '/node_modules') }\" && yarn cache clean"

function inspect-cert {
  openssl x509 -noout -text -in $1
}

function inspect-csr {
  openssl req -noout -text -in $1
}

function _ruby_ps1 {
  ruby -e "puts RUBY_VERSION"
}

C_RED="\[\033[0;31m\]"
C_GREEN="\[\033[0;32m\]"
C_YELLOW="\[\033[01;33m\]"
C_BLUE="\[\033[0;34m\]"
C_MAGENTA="\[\033[0;35m\]"
C_CYAN="\[\033[0;36m\]"
C_WHITE="\[\033[0;37m\]"
C_RESET="\[\033[00m\]"

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"

# set the prompt to show current working directory and git branch name, if it exists
PS1="$C_GREEN\w$C_RED [\$(_ruby_ps1)]$C_YELLOW\$(__git_ps1)$C_RESET\n\$ "
if [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi
