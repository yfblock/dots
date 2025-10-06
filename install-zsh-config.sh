#!/usr/bin/zsh
CURPATH=$(dirname $(realpath $0))
[[ ! -d ~/.zprezto ]] && git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# [[ ! -d ~/.zprezto ]] && ln -s $CURPATH/zprezto/runcoms
setopt EXTENDED_GLOB
for rcfile in $CURPATH/zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

[ ! -f "zsh-config/_dnf" ] && wget https://raw.githubusercontent.com/zsh-users/zsh/master/Completion/Redhat/Command/_dnf -O zsh-config/_dnf
[ ! -f "zsh-config/_dnf5" ] && wget https://raw.githubusercontent.com/zsh-users/zsh/master/Completion/Redhat/Command/_dnf5 -O zsh-config/_dnf5

