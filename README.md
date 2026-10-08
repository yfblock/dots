# Dots Directory

zsh(Oh My Zsh + p10k)、tmux、nvim(LazyVim)、kitty/wezterm、rofi 的 dotfiles,软链接方式部署。

## 安装

```bash
git clone https://github.com/yfblock/dots.git ~/dots
cd ~/dots
./install.sh
```

`install.sh` 是纯 bash 的交互式多选菜单(零依赖,适合新机器引导):
数字切换模块、`a` 全选/清空、Enter 安装、`q` 退出。
也支持非交互:

```bash
./install.sh --all          # 安装全部模块
./install.sh nvim tmux      # 只安装指定模块
./install.sh --list         # 列出可用模块
```

模块:`zsh` `tmux` `nvim` `kitty` `wezterm` `rofi` `fonts`(联网下载 Nerd Fonts)`musl`(联网下载交叉编译工具链)。

已存在的目标文件/目录会被跳过并标记 `[ EXISTS ]`,不会覆盖。

## 安装后

- zsh:首次启动按提示运行 `p10k configure` 生成 `~/.p10k.zsh`
- tmux:首次启动按 `prefix + I` 安装 TPM 插件
