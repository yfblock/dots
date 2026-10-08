#!/usr/bin/env bash
# Dots 交互式安装器(纯 bash,零依赖,适合新机器引导)
#
# 用法:
#   ./install.sh              交互式多选菜单
#   ./install.sh --all        安装全部模块
#   ./install.sh nvim tmux    只安装指定模块
#   ./install.sh --list       列出可用模块
set -u

CURPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

Green='\033[0;32m'; Yellow='\033[0;33m'; Red='\033[0;31m'
Cyan='\033[0;36m'; Bold='\033[1m'; CReset='\033[0m'

# 模块表: id|描述|默认选中(1/0)
MODULES=(
  "zsh|Oh My Zsh + p10k + dnf 补全|1"
  "tmux|tmux 配置 + TPM 插件管理器|1"
  "nvim|LazyVim 配置|1"
  "kitty|kitty 终端配置|1"
  "wezterm|wezterm 终端配置|1"
  "rofi|rofi 主题|1"
  "fonts|Nerd Fonts 字体(联网下载)|0"
  "musl|musl 交叉编译工具链(联网下载)|0"
)

# mod_field <模块索引> <字段号> : 取模块表的某个字段
mod_field() {
  local id desc default
  IFS='|' read -r id desc default <<<"${MODULES[$1]}"
  case $2 in
    0) echo "$id" ;;
    1) echo "$desc" ;;
    2) echo "$default" ;;
  esac
}

declare -A SELECTED=()
for i in "${!MODULES[@]}"; do
  SELECTED[$(mod_field "$i" 0)]=$(mod_field "$i" 2)
done

# linkcur <仓库内相对路径> <目标绝对路径> : 软链,已存在则跳过
linkcur() {
  local src="$CURPATH/$1" dst="$2"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    echo -e "  ${Yellow}[ EXISTS ]${CReset} $dst"
  else
    ln -s "$src" "$dst" && echo -e "  ${Green}[ DONE ]${CReset} $dst"
  fi
}

# ---------- 各模块安装逻辑 ----------

inst_zsh() { "$CURPATH/install-zsh-config.sh"; }

inst_tmux() {
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    mkdir -p "$HOME/.tmux/plugins"
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" \
      || { echo -e "  ${Red}[ FAIL ]${CReset} 无法克隆 tpm"; return 1; }
  else
    echo -e "  ${Yellow}[ EXISTS ]${CReset} ~/.tmux/plugins/tpm"
  fi
  linkcur tmux.conf "$HOME/.tmux.conf"
  echo "  提示: 首次启动 tmux 后按 prefix + I 安装插件"
}

inst_nvim()    { mkdir -p "$HOME/.config"; linkcur nvim "$HOME/.config/nvim"; }
inst_kitty()   { mkdir -p "$HOME/.config"; linkcur kitty "$HOME/.config/kitty"; }
inst_wezterm() { linkcur wezterm.lua "$HOME/.wezterm.lua"; }
inst_rofi()    { "$CURPATH/install-rofi-themes.sh"; }
inst_fonts()   { "$CURPATH/install-fonts.sh"; }
inst_musl()    { "$CURPATH/install-musl.sh"; }

# ---------- 交互菜单 ----------

draw_menu() {
  printf '\033[H\033[2J'
  echo -e "${Bold} Dots 安装器${CReset}"
  echo " ──────────────────────────────────────"
  local i id desc mark
  for i in "${!MODULES[@]}"; do
    id=$(mod_field "$i" 0); desc=$(mod_field "$i" 1)
    [[ ${SELECTED[$id]} == 1 ]] && mark="x" || mark=" "
    printf '  [%s] %d) %-8s %s\n' "$mark" "$((i + 1))" "$id" "$desc"
  done
  echo " ──────────────────────────────────────"
  echo "  数字: 切换选择   a: 全选/清空   Enter: 安装   q: 退出"
}

menu() {
  local key i id all
  while :; do
    draw_menu
    IFS= read -rsn1 key
    case $key in
      q)
        echo; echo "已退出,未做任何更改。"
        exit 0
        ;;
      '')
        break
        ;;
      a) # 全选中 -> 清空;否则 -> 全选
        all=1
        for i in "${!MODULES[@]}"; do
          id=$(mod_field "$i" 0)
          [[ ${SELECTED[$id]} == 1 ]] || all=0
        done
        for i in "${!MODULES[@]}"; do
          SELECTED[$(mod_field "$i" 0)]=$((1 - all))
        done
        ;;
      [1-9])
        i=$((10#$key - 1))
        (( i < ${#MODULES[@]} )) || continue
        id=$(mod_field "$i" 0)
        SELECTED[$id]=$((1 - SELECTED[$id]))
        ;;
    esac
  done
}

run_install() {
  local i id desc fail=0 any=0
  for i in "${!MODULES[@]}"; do
    id=$(mod_field "$i" 0); desc=$(mod_field "$i" 1)
    [[ ${SELECTED[$id]} == 1 ]] || continue
    any=1
    echo -e "\n${Cyan}==> ${Bold}${id}${CReset} ${desc}"
    "inst_$id" || { echo -e "  ${Red}[ FAIL ]${CReset} ${id} 安装失败"; fail=1; }
  done
  if (( ! any )); then
    echo "未选择任何模块。"
    return 0
  fi
  echo
  if (( fail )); then
    echo -e "${Red}部分模块安装失败,请检查上方日志。${CReset}"
    return 1
  fi
  echo -e "${Green}全部完成。${CReset}"
  echo "后续提示:"
  [[ ${SELECTED[zsh]} == 1 ]] && echo "  - zsh:  首次启动运行 p10k configure 生成 ~/.p10k.zsh"
  [[ ${SELECTED[tmux]} == 1 ]] && echo "  - tmux: 首次启动按 prefix + I 安装插件"
  return 0
}

# ---------- 入口 ----------

case ${1:-} in
  --list)
    for i in "${!MODULES[@]}"; do
      printf '%-8s %s\n' "$(mod_field "$i" 0)" "$(mod_field "$i" 1)"
    done
    exit 0
    ;;
  --all)
    for i in "${!MODULES[@]}"; do
      SELECTED[$(mod_field "$i" 0)]=1
    done
    ;;
  "")
    menu
    ;;
  *)
    for i in "${!MODULES[@]}"; do
      SELECTED[$(mod_field "$i" 0)]=0
    done
    for arg in "$@"; do
      if [[ -z ${SELECTED[$arg]+x} ]]; then
        echo "未知模块: $arg(运行 ./install.sh --list 查看可用模块)" >&2
        exit 2
      fi
      SELECTED[$arg]=1
    done
    ;;
esac

run_install
