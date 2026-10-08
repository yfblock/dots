#!/bin/bash
install_font() {
  if [ -d "$HOME/.local/share/fonts/$1" ]; then
    echo "  [ EXISTS ] $1"
    return 0
  fi
  wget -nc "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$1.zip" || return 1
  unzip -q "$1.zip" -d "$1" -x LICENCE.txt README.md || return 1
  mv "$1" "$HOME/.local/share/fonts/"
  rm -f "$1.zip"
}

mkdir -p "$HOME/.local/share/fonts"

install_font AdwaitaMono
install_font UbuntuSans
install_font Noto
install_font Ubuntu
install_font UbuntuMono
install_font RobotoMono
install_font JetbrainsMono
install_font Hack
install_font GeistMono
install_font FiraMono
install_font FiraCode
install_font DroidSansMono
install_font DejavuSansMono

fc-cache -f "$HOME/.local/share/fonts" >/dev/null 2>&1 || true
