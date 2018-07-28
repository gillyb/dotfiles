#!/usr/bin/env bash

# This script should be run directly from the online repository like this:
# curl -L https://github.com/elentok/dotfiles/raw/master/online_install.sh | bash
#
# Prerequisits:
# sudo apt-get install curl

cd ~

repo_root="https://github.com/gillyb/dotfiles"

echo "========================================"
echo "Cloning dotfiles"
git clone $repo_root .dotfiles

echo "========================================"
echo "Installing"
cd ~/.dotfiles
./install