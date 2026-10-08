#!/usr/bin/env zsh
CURPATH="$(cd "$(dirname "$0")" && pwd)"
ZDOT="${ZDOTDIR:-$HOME}"

# Oh My Zsh 本体
if [[ ! -d "$ZDOT/.oh-my-zsh" ]]; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZDOT/.oh-my-zsh"
fi
ZSH_CUSTOM_DIR="$ZDOT/.oh-my-zsh/custom"

# 第三方主题与插件
clone_if_missing() { # <目标目录> <仓库>
  if [[ ! -d "$1" ]]; then
    git clone --depth=1 "$2" "$1"
  fi
}
clone_if_missing "$ZSH_CUSTOM_DIR/themes/powerlevel10k" \
  https://github.com/romkatv/powerlevel10k.git
clone_if_missing "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" \
  https://github.com/zsh-users/zsh-autosuggestions
clone_if_missing "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" \
  https://github.com/zsh-users/zsh-syntax-highlighting
clone_if_missing "$ZSH_CUSTOM_DIR/plugins/zsh-history-substring-search" \
  https://github.com/zsh-users/zsh-history-substring-search

# 链接 runcoms(强制覆盖旧链接)
for rcfile in zshrc zprofile zshenv; do
  ln -sf "$CURPATH/zsh/$rcfile" "$ZDOT/.$rcfile"
done

# 清理旧 Prezto 遗留链接(仅当指向本仓库时删除)
for rc in .zlogin .zlogout .zpreztorc; do
  if [[ -L "$ZDOT/$rc" && "$(readlink "$ZDOT/$rc")" == */dots/* ]]; then
    rm -f "$ZDOT/$rc"
  fi
done

# 自定义 dnf/dnf5 补全
for comp in _dnf _dnf5; do
  if [[ ! -f "$CURPATH/zsh-config/$comp" ]]; then
    wget -q "https://raw.githubusercontent.com/zsh-users/zsh/master/Completion/Redhat/Command/$comp" \
      -O "$CURPATH/zsh-config/$comp"
  fi
done

# 清理旧补全缓存,确保新增 fpath 目录生效
rm -f "$ZDOT"/.zcompdump*(N)
