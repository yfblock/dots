#!/usr/bin/bash
CURPATH=$(dirname $(realpath $0))
[[ ! -d ~/.local/share/rofi/theme ]] && ln -s $CURPATH/rofi ~/.local/share/rofi
read -n 1 -p "Select theme(Y/n): " need_select
if [[ "$need_select" -eq "y" ]]; then 
  rofi -show run -dpi 1 --show-icons
fi
