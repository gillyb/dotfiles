#!/usr/bin/env bash

source ./helpers.sh

# This installs brew and brew cask if we dont have them already.

prerequisites() {
  HAS_BREW=$(which brew)

  if [ $? != 0 ]; then
    # Install brew
    info "Installing brew"
    if ! $DRY_RUN; then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    success "done"
  else
    info "brew installed already. skipping"
  fi

  HAS_BREW_CASK=$(brew cask)

  if [ $? != 0 ]; then
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
}
