return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  main = "ibl",
  opts = {
    exclude = {
      filetypes = { "help", "terminal", "dashboard", "packer", "NvimTree", "Trouble" },
      buftypes = { "terminal", "nofile" },
    },
  },
}
