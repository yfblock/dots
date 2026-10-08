#!/usr/bin/env bash
CURPATH="$(cd "$(dirname "$0")" && pwd)"

if [[ ! -e "$HOME/.local/share/rofi/themes" ]]; then
  mkdir -p "$HOME/.local/share"
  ln -s "$CURPATH/rofi" "$HOME/.local/share/rofi"
fi
