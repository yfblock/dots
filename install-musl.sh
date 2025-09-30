#!/bin/bash

ENVD=~/Env
Green='\033[0;32m'
Yellow='\033[0;33m'
CReset='\033[0m'

download_musl() {
  echo -n "Installing $1 to $ENVD/$1  "
  if [ -d "$ENVD/$1" ]; then
    echo -e "${Yellow}[ EXISTS ]${CReset}"
    return 0
  fi
  curl -L "$2" | tar -xz -C $ENVD/
  echo -e "${Green}[ DONE ]${CReset}"
}

download_musl_cc() {
  download_musl "$1" "https://musl.cc/$1.tgz"
}

mkdir -p ~/Env/
download_musl_cc aarch64-linux-musl-cross
download_musl_cc riscv64-linux-musl-cross
download_musl_cc x86_64-linux-musl-cross
download_musl loongarch64-linux-musl-cross https://github.com/LoongsonLab/oscomp-toolchains-for-oskernel/releases/download/loongarch64-linux-musl-cross-gcc-13.2.0/loongarch64-linux-musl-cross.tgz

