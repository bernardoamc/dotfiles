#!/usr/bin/env bash

set -e

log(){
  echo -e "$(tput setaf 2)> $*$(tput sgr0)"
}

warn(){
  echo -e "$(tput setaf 1)> $*$(tput sgr0)"
}

header(){
  echo
  echo -e "$(tput bold)$(tput setaf 6)### $* ###$(tput sgr0)"
  echo
}

ensure_symlink(){
  local source=$1
  local destination=$2

  if [ -h "$destination" ]
  then
    log "$destination is already symlinked"
  else
    log "Symlinking $source to $destination"
    ln -s "$source" "$destination"
  fi
}

ensure_directory(){
  local dir_path=$1

  if [ -d "$dir_path" ]
  then
    log "$dir_path already exists"
  else
    log "$dir_path does not exist. Creating."
    mkdir -p $dir_path
  fi
}

ensure_repo(){
  local repo_path=$1
  local repo_url=$2

  ensure_directory $repo_path

  (
    cd "$repo_path"
    if git rev-parse --is-inside-work-tree > /dev/null && [ "$repo_path" =  "$(git rev-parse --show-toplevel)" ]
    then
      log "$repo_path is a already a git repository. Updating."
      git pull origin master
    else
      log "$repo_path isn't a git repository. Creating."
      git clone "$repo_url" "$repo_path"
    fi
  )
}

header "Setting up config files"

# Config files
ensure_symlink ~/src/dotfiles/vimrc ~/.vimrc
ensure_symlink ~/src/dotfiles/gitconfig ~/.gitconfig
ensure_symlink ~/src/dotfiles/gitignore ~/.gitignore
ensure_symlink ~/src/dotfiles/gemrc ~/.gemrc
ensure_symlink ~/src/dotfiles/pryrc ~/.pryrc
ensure_symlink ~/src/dotfiles/gdbinit ~/.gdbinit
ensure_symlink ~/src/dotfiles/psqlrc ~/.psqlrc
ensure_symlink ~/src/dotfiles/tmux.conf ~/.tmux.conf
ensure_symlink ~/src/dotfiles/ctags ~/.ctags
ensure_symlink ~/src/dotfiles/bash_profile ~/.bash_profile

# Vim
ensure_repo ~/.vim/bundle/Vundle.vim git@github.com:VundleVim/Vundle.vim.git

if [ -x "$(command -v vim)" ]; then
  header "Installing Vim plugins"
  vim -s ~/src/dotfiles/install_plugins.vim
else
  header "Skipping Vim extensions"
fi

# Ruby
ensure_repo ~/.rbenv git@github.com:sstephenson/rbenv.git
ensure_repo ~/.rbenv/plugins/ruby-build git@github.com:sstephenson/ruby-build.git

# Node
ensure_repo ~/.nvm git@github.com:creationix/nvm.git

# VSCode
if [ -x "$(command -v code)" ]; then
  if [ -n "$is_mac" ]; then
    header "Symlinking VSCode config files"
    ensure_symlink ~/src/dotfiles/vscode.json ~/Library/Application\ Support/Code/User/settings.json
    ensure_symlink ~/src/dotfiles/vscode_keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
  fi

  header "Checking VSCode extensions"

  missing=$(comm -1 -3 <(code --list-extensions | sort) <(sort ~/src/dotfiles/vscode_extensions.txt))

  if [ -n "$missing" ]; then
    log "The following packages are not installed"
    echo $missing
    log "Installing"
    echo "$missing" | xargs -n 1 code --install-extension
  else
    log "All VSCode extensions are installeds"
  fi

  header "Saving installed extensions"
  code --list-extensions | sort > ~/src/dotfiles/vscode_extensions.txt
  log "Done."
else
  header "Skipping VSCode extensions"
fi

# Homebrew
if [ -x "$(command -v brew)" ]; then
  header "Checking for recommended Homebrew packages"

  missing=$(comm -1 -3 <(brew list --full-name | sort) <(sort ~/src/dotfiles/brew_packages.txt))

  if [ -n "$missing" ]; then
    log "The following packages are not installed"
    echo "$missing"
    log "Installing"
    echo "$missing" | xargs -n 1 brew install
  else
    log "All recommended Homebrew packages installed"
  fi
else
  header "Skipping Homebrew"
fi
