-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.rustaceanvim = {
  server = {
    load_vscode_settings = true,
    default_settings = {
      -- rust-analyzer language server configuration
      -- ["rust-analyzer"] = {
      --   check = {
      --     allTargets = false,
      --   },
      --   cargo = {
      --     allTargets = false,
      --     -- target = "aarch64-unknown-linux-gnu",
      --   },
      -- },
    },
  },
}

-- disable auto format
-- vim.g.lazyvim_eslint_auto_format = false
vim.g.autoformat = false

local opt = vim.opt

function my_paste(reg)
  return function(lines)
    --[ 返回 “” 寄存器的内容，用来作为 p 操作符的粘贴物 ]
    local content = vim.fn.getreg('"')
    return vim.split(content, "\n")
  end
end

if os.getenv("SSH_TTY") == nil then
  --[ 当前环境为本地环境，也包括 wsl ]
  opt.clipboard:append("unnamedplus")
else
  -- 当 ssh 的环境下关闭所有的动画用以提高性能和传输速度
  vim.g.snacks_animate = false
  opt.clipboard:append("unnamedplus")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      --[ 小括号里面的内容可能是毫无意义的，但是保持原样可能看起来更好一点 ]
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
end
