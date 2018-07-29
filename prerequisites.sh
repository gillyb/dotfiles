#!/usr/bin/env bash

source ./helpers.sh

# This installs brew and brew cask if we dont have them already.

# OS=""

prerequisites() {
  set +e

  # If we're not using a mac, then we first need to install ruby (otherwise we can't get brew)
  # OS=$(uname -s)
  # if [ $OS != "Darwin" ]; then
  #   info "Installing ruby"
  #   sudo pacman -S ruby --noconfirm
  # fi

  which brew > /dev/null

  if [ $? -ne 0 ]; then
    # Install brew
    info "Installing brew"
    if ! $DRY_RUN; then
      # This will probably only work on mac (not on mac we should install ruby first)
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    success "done"
  else
    info "brew installed already. skipping"
  fi

  brew cask > /dev/null

  if [ $? -ne 0 ]; then
    # Install brew cask
    info "Installing brew-cask"
    if ! $DRY_RUN; then
      brew tap brew/cask
    fi
    success "done"
  else
    info "brew-cask installed already. skipping"
  fi

  success "prerequisites stage done."
  set -e
}
