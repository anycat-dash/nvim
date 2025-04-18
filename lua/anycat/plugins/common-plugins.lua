return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "hrsh7th/cmp-buffer", lazy = true }, -- source for text in buffer
  { "hrsh7th/cmp-path", lazy = true  }, -- source for file system paths
  {
      "L3MON4D3/LuaSnip",
      lazy = true,
      version = "v2.*",
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
  },
}
