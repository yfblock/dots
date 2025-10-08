if os.getenv("SSH_TTY") == nil then return {} end

return {
  {
    "sphamba/smear-cursor.nvim",
    enabled = false
  },
  {
    "echasnovski/mini.animate",
    enabled = false
  }
}
