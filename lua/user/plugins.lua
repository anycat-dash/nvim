local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"          -- Have packer manage itself
  use "nvim-lua/popup.nvim"             -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"           -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs"           -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim"           -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"    -- Icons
  use "kyazdani42/nvim-tree.lua"        -- File Explorer
  use "akinsho/bufferline.nvim"         -- Buffers bar
  use "moll/vim-bbye"                   -- Close Buffers without messing up the buffers title bar
  use "nvim-lualine/lualine.nvim"       -- Status line
  -- use "akinsho/toggleterm.nvim"    -- Open terminal from within vim
  use "ahmedkhalf/project.nvim"         -- explore recently opened projects
  use "lewis6991/impatient.nvim"        -- improves startup time for neovim
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"              -- IDE style homepage
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"            -- Keybinding help context

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"
  -- use "morhetz/gruvbox" -- doesn't work with navigator
  -- use "ray-x/aurora" -- aurora colorscheme with lsp and treesitter support. disabled because buggy.
  use 'folke/tokyonight.nvim'       -- The best colorscheme. Cool colors.
  use 'sainnhe/sonokai'             -- This is pretty good too. Warm colors.
  use 'norcalli/nvim-colorizer.lua' -- Highlights hex color codes in the colors they represent

  -- cmp plugins
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Language servers and debuggers
  -- use "neovim/nvim-lspconfig" -- plugin to enable LSP. This is commented because lsp is installed by navigator.
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use("williamboman/mason.nvim")
  use({
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({})
    end,
  }) -- swwitching to mason instead of nvim-lsp-installer
  -- Navigator: Plugin with in built installation of LSP and setup of 20 common LSP servers including go,ts,lua etc.
  -- Uses nvim-lsp-installer to install LSP
  use({
    'ray-x/navigator.lua',
    requires = {
      { 'ray-x/guihua.lua',     run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
  })
  use "mfussenegger/nvim-dap"           -- Plugin implementing DAP (Debug Adapter protocol)
  use "rcarriga/nvim-dap-ui"            -- While in debugging mode using DAP, show different debugging elements in vim windows
  use "theHamsta/nvim-dap-virtual-text" -- While in debugging mode using DAP, highlight virtual text

  -- Golang specific
  use "ray-x/go.nvim" -- Go tools - works on top of LSP, treesitter, DAP (debug adapter protocol)

  -- Typescript/Node specific
  use "eliba2/vim-node-inspect" -- run/attach-to node programs in inspect mode (debugging). Doesn't use DAP.

  -- Telescope
  use "nvim-telescope/telescope.nvim"                -- Fuzzy Search for Files, Text, Keybinding, Code Actions etc.
  use "nvim-telescope/telescope-dap.nvim"            -- Telescope extension for nvim-dap
  use "nvim-telescope/telescope-live-grep-args.nvim" -- Telescope extension for better fuzzy search

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  --use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "tpope/vim-fugitive"      -- git operations inside vim
  use "lewis6991/gitsigns.nvim" -- highlight additions/deletions/changes in the file
  use "ruifm/gitlinker.nvim"    -- open links on GitHub
  -- use "github/copilot.vim"      -- github copilot
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
