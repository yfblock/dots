#!/bin/bash

install_font() {
  if [ -d "~/.local/share/fonts/$1" ]; then
    echo "FileExists"
    return 0
  fi
  wget -nc https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$1.zip
  unzip $1.zip -d $1 -x LICENCE.txt README.md
  mv $1 ~/.local/share/fonts/
  rm -rf $1
}

mkdir -p ~/.local/share/fonts

# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuSans.zip
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
