# Neovim Configuration

A personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim) with LSP support, autocompletion, fuzzy finding, and a curated set of plugins for a productive editing experience.

## Prerequisites

- **Neovim** >= 0.9 (built with LuaJIT)
- **Git**
- A [Nerd Font](https://www.nerdfonts.com/) installed and configured in your terminal (for icons)
- **ripgrep** (`brew install ripgrep`) for live grep in Telescope
- **Node.js** (required by some LSP servers)
- **Go** (if you plan to use the Go development features)

## Installation

1. Back up any existing Neovim config:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone this repository:

   ```bash
   git clone https://github.com/anycat-dash/nvim.git ~/.config/nvim
   ```

3. Open Neovim:

   ```bash
   nvim
   ```

   On the first launch, lazy.nvim will automatically install itself and all plugins. Wait for the installation to finish, then restart Neovim.

4. Install LSP servers via Mason. Open Neovim and run:

   ```
   :Mason
   ```

   Install the language servers you need (e.g., `lua_ls`, `gopls`, `pyright`, `ts_ls`, `terraformls`).

## Structure

```
~/.config/nvim/
├── init.lua                       -- Entry point, loads core modules
├── lazy-lock.json                 -- Plugin version lockfile
└── lua/anycat/
    ├── options.lua                -- Editor options (tabs, line numbers, etc.)
    ├── keymaps.lua                -- Core keybindings
    ├── autocommands.lua           -- Auto-commands (formatting, highlights)
    ├── lazy.lua                   -- lazy.nvim bootstrap and setup
    └── plugins/                   -- One file per plugin (lazy.nvim convention)
        ├── alpha.lua              -- Dashboard / start screen
        ├── autopairs.lua          -- Auto-close brackets and quotes
        ├── bufdel.lua             -- Clean buffer deletion
        ├── bufferline.lua         -- Tab-style buffer bar
        ├── cmp.lua                -- Autocompletion engine
        ├── colorscheme.lua        -- Tokyo Night theme
        ├── comment.lua            -- Toggle comments
        ├── common-plugins.lua     -- Shared dependencies (plenary, luasnip, etc.)
        ├── dap.lua                -- Debug Adapter Protocol support
        ├── gitsigns.lua           -- Git change indicators in the gutter
        ├── go.lua                 -- Go development tools
        ├── indent-blankline.lua   -- Indentation guides
        ├── lspconfig.lua          -- LSP client configuration
        ├── lualine.lua            -- Status line
        ├── mason.lua              -- LSP server installer
        ├── nvim-tree.lua          -- File explorer sidebar
        ├── openingh.lua           -- Open current file on GitHub
        ├── project.lua            -- Project detection and switching
        ├── spectre.lua            -- Search and replace across files
        ├── telescope.lua          -- Fuzzy finder
        ├── treesitter.lua         -- Syntax highlighting and code parsing
        └── whichkey.lua           -- Keybinding hints popup
```

## Keybindings

The **leader key** is `Space`.

> **Note:** This config uses a non-standard movement layout: `j` = left, `k` = down, `i` = up (instead of the default h/j/k). `a` enters insert mode (instead of `i`).

### General

| Key | Mode | Action |
|-----|------|--------|
| `Space w` | Normal | Save file |
| `Space q` | Normal | Close buffer |
| `Space Q` | Normal | Close window |
| `Space e` | Normal | Toggle file explorer |
| `Space h` | Normal | Clear search highlight |
| `kj` | Insert | Exit insert mode |

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl+j` | Normal | Move to left window |
| `Ctrl+l` | Normal | Move to right window |
| `Shift+l` | Normal | Next buffer tab |
| `Shift+j` | Normal | Previous buffer tab |
| `Ctrl+Arrow` | Normal | Resize window splits |

### Finding Things (Telescope)

| Key | Mode | Action |
|-----|------|--------|
| `Space f` | Normal | Find files |
| `Space F` | Normal | Live grep (search text in files) |
| `Space b` | Normal | List open buffers |
| `Space sr` | Normal | Recent files |
| `Space sk` | Normal | Search keymaps |
| `Space sh` | Normal | Search help tags |
| `Space sb` | Normal | Search git branches |
| `Space sc` | Normal | Search colorschemes |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `Space gl` | Normal | Blame current line |
| `Space gd` | Normal | Diff against HEAD |
| `Space gh` | Normal/Visual | Open file/selection on GitHub |
| `Space gj` / `gk` | Normal | Next / previous hunk |
| `Space gs` | Normal | Stage hunk |
| `Space gr` | Normal | Reset hunk |
| `Space gp` | Normal | Preview hunk |

### LSP (when a language server is attached)

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Find references |
| `gi` | Normal | Go to implementation |
| `K` | Normal | Hover documentation |
| `Ctrl+k` | Normal | Signature help |
| `Space rn` | Normal | Rename symbol |
| `Space ca` | Normal | Code action |
| `Space dw` | Normal | Show diagnostics float |
| `[d` / `]d` | Normal | Previous / next diagnostic |

### Go Development

| Key | Mode | Action |
|-----|------|--------|
| `Space rt` | Normal | Run test under cursor |
| `Space rs` | Normal | Run server |
| `Space rf` | Normal | Format file |
| `Space ra` | Normal | Fill struct |
| `Space rd` | Normal | Start debugger |
| `Space rb` | Normal | Toggle breakpoint |

### Code Folding

| Key | Mode | Action |
|-----|------|--------|
| `Space o` | Normal | Open all folds |
| `Space c` | Normal | Close all folds |

## LSP Servers

The following LSP servers are pre-configured with format-on-save:

- **gopls** -- Go
- **pyright** -- Python
- **ts_ls** -- TypeScript / JavaScript
- **terraformls** -- Terraform
- **lua_ls** -- Lua

Any additional server installed via Mason will work with default settings automatically.

## Colorscheme

The default colorscheme is [Tokyo Night](https://github.com/folke/tokyonight.nvim). To change it, edit `lua/anycat/plugins/colorscheme.lua`.

## Tips for Neovim Beginners

- Press `Space` and wait -- **which-key** will show you all available keybindings.
- Use `:Mason` to install/manage language servers, linters, and formatters.
- Use `:Lazy` to manage plugins (install, update, clean).
- Use `:checkhealth` to diagnose any missing dependencies.
- The file explorer (`Space e`) is a good way to browse the project tree.
- Telescope (`Space f` to find files, `Space F` to search text) is the fastest way to navigate.
