#!/usr/bin/env bash

# This script should be run directly from the online repository like this:
# curl -L https://github.com/gillyb/dotfiles/raw/master/online_install.sh | bash
#
# Prerequisits:
# sudo apt-get install curl

cd ~

repo_root="https://github.com/gillyb/dotfiles"

which -s git
if [ $? != 0 ]; then
  echo
  info "If you're having problems then I feel bad for you son"
  info "I have 99 problems but not having git ain't one"
  echo
  info "You need git to download this repo and run it"
  info "Install git and come back to me son"
  echo
  exit 1
fi

echo
echo "Cloning dotfiles..."
echo
git clone $repo_root dotfiles

echo
echo "Installing..."
echo
cd ~/dotfiles
./install
