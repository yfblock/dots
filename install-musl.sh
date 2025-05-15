#!/bin/bash

ENVD=~/Env
Green='\033[0;32m'
Yellow='\033[0;33m'
CReset='\033[0m'

download_musl() {
  echo -n "Installing $1 to $ENV/$1  "
  if [ -d "$ENVD/$1" ]; then
    echo -e "${Yellow}[ EXISTS ]${CReset}"
    return 0
  fi
  curl -L https://musl.cc/$1.tgz | tar -xz -C $ENVD/
  echo -e "${Green}[ DONE ]${CReset}"
}

mkdir -p ~/Env/
download_musl aarch64-linux-musl-cross
download_musl riscv64-linux-musl-cross
download_musl x86_64-linux-musl-cross
