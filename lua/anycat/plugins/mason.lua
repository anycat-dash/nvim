return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- typescript
        "typescript-language-server", "js-debug-adapter",
        -- golang
        "gopls", "delve", "gomodifytags", "goimports", "gofumpt",
        -- terraform
        "terraform-ls", "tflint",
        -- lua
        "lua-language-server"
      },
    },
  },
  { "williamboman/mason-lspconfig.nvim", config = function() end },
}
