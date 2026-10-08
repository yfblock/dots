if os.getenv("SSH_TTY") == nil then return {} end

return {
  {
    "sphamba/smear-cursor.nvim",
    enabled = false
  },
  {
    "nvim-mini/mini.animate",
    enabled = false
  }
}
