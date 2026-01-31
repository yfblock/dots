-- lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",
    -- opts = {
    --   -- 这里配置终端模块
    --   terminal = {
    --     win = {
    --       -- 悬浮窗样式配置
    --       position = "float",   -- 强制使用悬浮模式
    --       backdrop = 60,        -- 背景遮罩透明度 (0-100)
    --       height = 0.95,         -- 高度：0.9 = 90% 屏幕高度
    --       width = 0.95,          -- 宽度：0.9 = 90% 屏幕宽度
    --       border = "rounded",   -- 边框样式: "single", "double", "rounded", "solid", "none"
    --
    --       -- 更多可选配置:
    --       -- row = 2,           -- 手动指定起始行
    --       -- col = 2,           -- 手动指定起始列
    --       zindex = 50,          -- 层级
    --     },
    --   },
    -- },
    keys = {
      {
        "<c-/>",
        function()
          -- 在这里调用时传入特定的 win 配置
          Snacks.terminal.toggle(nil, {
            win = {
              position = "float",
              width = 0.95,
              height = 0.95,
              border = "rounded",
              title = " Float Term ",
              title_pos = "center",
            }
          })
        end,
        desc = "Toggle Terminal",
        mode = {"n", "t"}
      },
      {
        "<leader>a", -- 快捷键：空格 + a (代表 Agent)
        function()
          -- 这里的 "cursor-agent" 必须替换成你在终端里启动该工具的真实命令
          -- 比如 "aider", "gh copilot repl", "mods" 等
          Snacks.terminal.toggle("cursor agent", {
            win = {
              position = "float",
              backdrop = 100,    -- 背景全黑，沉浸式体验
              height = 0.9,      -- 90% 高度
              width = 0.9,       -- 90% 宽度
              border = "rounded",
              title = " Cursor Agent ", -- 窗口标题
              title_pos = "center",
            },
            -- interactive = true, -- 保持交互模式
            -- 关键：设置关闭时自动杀掉进程还是保持后台？
            -- 默认是保持后台，如果你希望每次关闭都重置，设置 kill = true
          })
        end,
        desc = "Open Cursor Agent",
        mode = {"n"}
      },
    }
  },
}
