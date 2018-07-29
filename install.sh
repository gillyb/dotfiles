#!/usr/bin/env bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# $DOTF will be the directory this repo is cloned
DOTF=`dirname ${BASH_SOURCE[0]-$0}`
export DOTF=`cd $DOTF && pwd`

source ./helpers.sh
source ./prerequisites.sh

# Parse input parameters
APP=""
DRY_RUN=false
NO_GUI=false
POSITIONAL=()

while [[ $# -gt 0 ]]
do
  key="$1"

  # TODO: add 'help' option that will print explanation
  case $key in
    -a|--app)     # '-a <app_name>' or '--app <app_name>' to install a specific app
    APP="$2"
    shift # pass argument
    shift # pass value
    ;;
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

# Check if we only want to install a specific app
if [ ! -z $APP ]; then
  header "Preparing to install $APP"
  install_plugin $APP
  exit 0
fi


# TODO: Create description file for each app
# TODO: Create "slow" mode that allows user to confirm each installation


header "Before installing apps, there are some prerequisites"
prerequisites

header "This is going to install all of these:"
list_plugins

if confirm "\nAre you sure you want to continue?" yes; then

  for app in ./installations/*/ ; do
    # Extract name of app from dir
    A=${app##./installations/}
    CURRENT_APP=${A%/}

    # Install app
    install_plugin $CURRENT_APP
  done

fi

update() {
  header "Updating dotfiles"
  cd $DOTF

  bullet "Pulling changes... "
  old_head=`git rev-parse HEAD`
  git pull
  new_head=`git rev-parse HEAD`

  if [ "$old_head" != "$new_head" ]; then
    echo -e "\nPulled the following changes:"
    git changelog ${old_head}..${new_head}

    echo -ne "\nPress any key to run the installer..."
    read -n 1

    bullet 'Updating brew... '
    brew update

    install
  fi
}

show_done() {
  echo -e "$GREEN=========================="
  echo "Done ($(benchmark-stop))"
  echo -e "==========================$RESET"
}

exit 0