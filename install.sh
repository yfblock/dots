#!/bin/bash

CURPATH=$(dirname $(realpath $0))

Green='\033[0;32m'
Yellow='\033[0;33m'
CReset='\033[0m'

linkcur() {
  echo -n "installing $1 to $CURPATH/$2    "
  if [ ! -e "$2" ]; then
    ln -s $CURPATH/$1 $2
    echo -e "${Green}[ DONE ]${CReset}"
  else
    echo -e "${Yellow}[ EXISTS ]${CReset}"
  fi
}

linkcur nvim ~/.config/nvim
linkcur wezterm.lua ~/.wezterm.lua
linkcur kitty ~/.config/kitty
linkcur tmux.conf ~/.tmux.conf
