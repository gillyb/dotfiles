#!/usr/bin/env bash

# Colors {{{1
export BLACK="\033[30m"
export GRAY="\033[1;30m"
export RED="\033[31m"
export GREEN="\033[32m"
export YELLOW="\033[33m"
export BLUE="\033[34m"
export CYAN="\033[36m"
export UNDERLINE="\033[4m"
export RESET="\033[0m"
export CLEAR_LINE="\r\033[K"
export BOLD="\033[1m"

# Special Characters {{{1

export HOURGLASS="⏳ "



# display methods (header/bullet/info/success/error) {{{1
title() {
  echo -e "\n${BLUE}$*"
  echo "$*" | sed 's/./=/g'
  echo -e $RESET
}

header() {
  echo -e "\n${BLUE}${BOLD}● $*$RESET"
}

bullet() {
  echo -e -n "${YELLOW}➜$RESET $*"
}

progress() {
  printf "${BLUE}${HOURGLASS} ${PROGRESS_PREFIX}$*..."
}

clear_line() {
  printf "$CLEAR_LINE"
}

info() {
  echo -e "${CYAN} --> $*$RESET"
}

success() {
  printf "${GREEN}✔ $*$RESET\n"
}

error() {
  echo -e "${RED}✘ $*$RESET"
}

# confirm {{{1
confirm() {
  local default=${2:-no}
  ask "${1} (yes/no)?" yesno $default
  [ "$yesno" = "yes" -o "$yesno" = "y" ]
  return $?
}

# ask {{{1
# (by @n0nick)
# Usage:
#   ask "What's up?" answer "ok"
#   echo $answer
ask() {
  local question=$1
  local default=${3:-}
  local resultvar=$2

  echo -ne "$question "
  if [ "$default" ]; then
    echo -n "[$default] "
  fi
  read ${read_args:-} reply
  echo

  reply="${reply:-$default}"
  reply=$(echo $reply | sed "s/'/'\"'\"'/g")
  eval $resultvar="'$reply'"
}

pause() {
  local text=${1:-Press any key to continue... }
  echo -ne "$text"
  read -n 1
}

list_plugins() {
  /bin/ls -1 ./installations | sort
}

install_plugin() {
  bullet "Installing $1\n"
  local install="./installations/$1/install"

  # Make sure package exists
  if [ ! -f "$install" ]; then
    error "Can't find package '$1'"
    exit 1
  fi

  if [ -z $DRY_RUN ]; then
    eval $install

    # Check status of installation
    if [ $? -eq 0 ]; then
      success "done\n"
    else
      error "Failure..."
      exit 1
    fi
  else
    success "done\n"
  fi
}

# Create a symbolic link.
# Usage: symlink <src> <destination>
symlink() {
  source=$1
  target=$2

  bullet "Linking $source\n      ==> ${target}... "
  if [ -e "$target" ]; then
    if [ -h "$target" ]; then
      if [ "$source" == "$(readlink "$target")" ]; then
        info " already exists"
        return
      fi
    fi

    # TODO: Implement backup mechanism!
    error "Symbolic link already exists"
    info "Won't override until I implement a backup helper method."
    exit 1
    # backup "$target"
  fi

  ln -sf "$source" "$target"
  if [ $? != 0 ]; then
    info "  Can't create link, trying with sudo:"
    sudo ln -sf "$source" "$target"
    if [ $? != 0 ]; then
      error "failed"
      exit 1
    fi
  fi
  if [ $? == 0 ]; then
    success "done"
  fi
}

current_dir() {
  $( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )
}