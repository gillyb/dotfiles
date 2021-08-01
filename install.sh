#!/usr/bin/env bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -uo pipefail

# Basic dependencies 
source ./helpers.sh

# $DOTF will be the directory this repo is cloned
DOTF=`dirname ${BASH_SOURCE[0]-$0}`
export DOTF=`cd $DOTF && pwd`

title "Running install script"
info "Currently in: ${DOTF}"


#source ./prerequisites.sh

# Parse input parameters
export DRY_RUN=false

if [[ $# -gt 0 ]]; then
  if [[ -n "$1" && $1 == "-d" ]]; then
    DRY_RUN=true
    info "Running in dry mode"
  fi
fi



# 
# Check if brew is installed
# 
echo ""
check "Checking if brew is installed"
which -s brew
if [ $? != 0 ]; then
  info "Brew is missing"
  info "Installing brew..."
  if ! $DRY_RUN; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  success "Done installing brew"
else
  success "Brew is installed"
  info "Making sure brew is up to date"
  if ! $DRY_RUN; then
    brew update
  fi
  success "Done updating brew"
fi
if [ $? -ne 0 ]; then
  error "Failed to install or update brew"
  exit 1
fi

# 
# Install nodejs & npm (using 'n')
# 
echo ""
check "Checking if node is installed"
which -s n
if [ $? != 0 ]; then
  info "Node is missing"
  info "Installing node (with 'n')..."
  if ! $DRY_RUN; then
    brew install n
  fi
  success "node installed"
fi
info "Making sure you have latest version of node"
if ! $DRY_RUN; then
  sudo n latest
fi
success "Latest node version installed"
if [ $? -eq 0 ]; then
  success "Done installing/updating nodejs"
else
  error "Failed to install/update nodejs"
  exit 1
fi

# Install some global node packages
echo ""
info "Installing global node packages..."
NODE_PACKAGES=('webpack' 'webpack-cli' 'typescript' \
               'typescript-language-server' \
               'eslint' 'jest' 'concurrently' \
               'serverless' 'neovim' '@gillyb/nrun')
for package in "${NODE_PACKAGES[@]}"; do
  minor "Running: npm install -g ${package}"
  if ! $DRY_RUN; then
    eval "sudo npm install -g ${package}"
    if [ $? -eq 0 ]; then
      success "Installed ${package}"
    else
      error "Failed to install ${package}"
      exit 1
    fi
  fi
done

echo ""
echo ""
success "Installation is complete :)"
echo ""
echo ""
exit 0
