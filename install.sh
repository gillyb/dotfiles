#!/usr/bin/env bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -uo pipefail

# Basic dependencies 
source ./helpers.sh

# $DOTF will be the directory this repo is cloned
DOTF=`dirname ${BASH_SOURCE[0]-$0}`
export DOTF=`cd $DOTF && pwd`

echo header "Currently in: ${DOTF}"


#source ./prerequisites.sh

# Parse input parameters
export DRY_RUN=false
export NO_GUI=false
export POSITIONAL=()   # This is for extra parameters - Not sure I actually need this

while [[ $# -gt 0 ]]
do
  key="$1"

  # TODO: add 'help' option that will print explanation
  case $key in
    -d|--dry-run)
    DRY_RUN=true
    info "(Running in DRY mode)"
    shift # pass argument
    ;;
    --no-gui)
    NO_GUI=true
    info "'no gui mode' - Won't install any apps that require a gui"
    shift
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # pass argument
    ;;
  esac
done


# 
# Check if brew is installed
# 
header "You need brew"
info "Checking if brew is installed..."
which -s brew
if [ $? != 0 ]; then
  info "Brew is missing"
  info "Installing brew..."
  if ! $DRY_RUN; then
    # This will probably only work on mac
    # If this doesn't work, then try '/usr/bin/ruby' or ruby might not be installed
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  info "Done installing brew"
  info "Installing brew-cask..."
  if ! $DRY_RUN; then
    brew tap caskroom/cask
  fi
  info "Done installing brew-cask"
else
  info "Brew is installed"
  info "Updating brew"
  if ! $DRY_RUN; then
    brew update
  fi
  info "Done updating brew"
  info "Installing brew-cask..."
  if ! $DRY_RUN; then
    brew tap caskroom/cask
  fi
  info "Done installing brew-cask"
fi
if [ $? -eq 0 ]; then
  success "Done installing/updating brew"
else
  error "Failed to install or update brew"
  exit 1
fi



# 
# Install nodejs & npm (using 'n')
# 
header "You need nodejs"
info "Checking for 'n' (node version manager)"
which -s n
if [ $? != 0 ]; then
  info "Installing 'n'..."
  if ! $DRY_RUN; then
    curl -L https://git.io/n-install | bash
  fi
  info "'n' installed"
fi
info "Making sure you have latest version of node"
if ! $DRY_RUN; then
  n latest
fi
info "Latest node version installed"
if [ $? -eq 0 ]; then
  success "Done installing/updating nodejs"
else
  error "Failed to install/update nodejs"
  exit 1
fi




#
# Use nodejs from here to install the rest
# 
node node/install.js
# TODO: Run nodejs install script here...
if [ $? != 0 ]; then
  error "An error occurred while running node install script"
  exit 1
fi

exit 0
