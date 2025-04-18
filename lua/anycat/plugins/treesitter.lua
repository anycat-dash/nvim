return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  main = 'nvim-treesitter.configs',
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    autotag = {
      enable = true,
    },
    ensure_installed = {
      "json",
      "python",
      "javascript", "typescript", "tsx",
      "go", "gomod", "gowork", "gosum",
      "markdown",
      "bash",
      "lua",
      "dockerfile",
      "gitignore",
      "hcl"
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    rainbow = {
      enable = true,
      disable = { "html" },
      extended_mode = false,
      max_file_lines = nil,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  },
}
