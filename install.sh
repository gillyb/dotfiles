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


# Input parameters
export DRY_RUN=false
export VERBOSE=false

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    # TODO: Add 'help' option
    # TODO: Add option to install only specific folder
    -d|--dry-run)
      DRY_RUN=true
      shift # pass argument
      ;;
    -v|--verbose)
      VERBOSE=true
      shift # pass argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # pass argument
      ;;
  esac
done

info "DRY_RUN = ${DRY_RUN}"
info "VERBOSE = ${VERBOSE}"

export BE_QUIET="&>/dev/null"
if [ $VERBOSE == true ]; then
  BE_QUIET=""
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
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
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
# Install nodejs & npm (using 'nvm')
# 
echo ""
check "Checking if node is installed"
which -s nvm
if [ $? != 0 ]; then
  info "nvm is missing"
  info "Installing nvm"
  if ! $DRY_RUN; then
    # brew install n
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
    # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  fi
  success "nvm installed"

  info "Configuring npm global prefix"
  mkdir -p ~/.npm-global/lib
  npm config set prefix '~/.npm-global'
  export PATH=~/.npm-global/bin:$PATH
fi
info "Making sure you have latest version of node"
if ! $DRY_RUN; then
  nvm use latest
fi
success "Latest node version installed"
if [ $? -eq 0 ]; then
  success "Done installing/updating nodejs"
else
  error "Failed to install/update nodejs"
  exit 1
fi

exit 1

# Install some global node packages
echo ""
info "Installing global node packages..."
NODE_PACKAGES=('webpack'                     \
               'webpack-cli'                 \
               'typescript'                  \
               'ts-node'                     \
               'typescript-language-server'  \
               'eslint'                      \
               'jest'                        \
               'concurrently'                \
               'neovim'                      \
               'pyright'                     \
               'next'                        \
               'serve'                       \
               '@gillyb/nrun'                \
)

for package in "${NODE_PACKAGES[@]}"; do
  minor "Installing '${package}'"
  if ! $DRY_RUN; then
    eval "sudo npm install -g ${package} ${BE_QUIET}"
    if [ $? -eq 0 ]; then
      success "Installed ${package}"
    else
      error "Failed to install '${package}'"
      error "You can try running this script again with --verbose"
      pause
    fi
  fi
done




# Go through various installations

# Start with some basic utilities
echo ""
info "Installing some basic utils with brew"
BREW_UTILS=(       \
  'tmux'           \
  'fzf'            \
  'bat'            \
  'fd'             \
  'ripgrep'        \
  'jq'             \
  'python'         \
  'python@3.8'     \
  'htop'           \
  'diff-so-fancy'  \
  'ncdu'           \
  'deno'           \
  'yarn'           \
)
for package in "${BREW_UTILS[@]}"; do
  minor "Installing '${package}'"
  if ! $DRY_RUN; then
    eval "brew install ${package} ${BE_QUIET}"
    if [ $? -eq 0 ]; then
      success "Installed '${package}'"
    else
      error "Failed to install '${package}'"
      error "You can try running this script again with --verbose"
      pause
    fi
  fi
done

echo ""
info "Installing some basic utils with brew-cask"
BREW_CASK_UTILS=(       \
  'google-chrome'       \
  'sublime-text'        \
  'iterm2'              \
  'wezterm'             \
  'ngrok'               \
  'font-hack-nerd-font' \
  'whatsapp'            \
  'telegram'            \
  'visual-studio-code'  \
  'github'              \
  'spotify'             \
  'prusaslicer'         \
  'notion'              \
  'font-monaspace'      \
  'docker'              \
  'chatgpt'             \
)
for package in "${BREW_CASK_UTILS[@]}"; do
  minor "Installing '${package}'"
  if ! $DRY_RUN; then
    eval "brew install ${package} ${BE_QUIET}"
    if [ $? -eq 0 ]; then
      success "Installed '${package}'"
    else
      error "Failed to install '${package}'"
      error "You can try running this script again with --verbose"
      pause
    fi
  fi
done


# Now use node to install the rest
echo ""
echo ""
echo ""
info "  Starting app installations.. "
echo ""
node node/install.js
if [ $? != 0 ]; then
  error "\nFailed to run some node installations.."
  exit 1
end



echo ""
echo ""
success "Installation is complete :)"
echo ""
echo ""

exit 0

