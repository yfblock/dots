-- Deno 与 TypeScript 项目按根标记自动选择 LSP:
--   deno.json / deno.jsonc -> denols;package.json -> ts_ls
vim.lsp.config("denols", {
  root_markers = { "deno.json", "deno.jsonc" },
})

vim.lsp.config("ts_ls", {
  root_markers = { "package.json" },
  single_file_support = false,
})
vim.lsp.enable({ "denols", "ts_ls" })

return {}
