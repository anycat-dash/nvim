return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim",    opts = {} },
    { "RRethy/vim-illuminate" },
  },
  config = function()
    local nvim_lsp = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    local protocol = require("vim.lsp.protocol")

    local function lsp_highlight_document(client)
      -- Set autocommands conditional on server_capabilities
      local status_ok, illuminate = pcall(require, "illuminate")
      if not status_ok then
        return
      end
      illuminate.on_attach(client)
      -- end
    end

    local function lsp_keymaps(bufnr)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dw", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gl",
        '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
        opts
      )
      vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
      vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
    end

    local on_attach = function(client, bufnr)
      lsp_keymaps(bufnr)
      lsp_highlight_document(client)

      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp._on_insert_enter({})

      -- format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
      if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
      end
    end

    -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local capabilities = protocol.make_client_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok then
      print "using cmp_nvim_lsp capabilites"
      capabilities = cmp_nvim_lsp.default_capabilities()
    end

    mason_lspconfig.setup_handlers({
      function(server)
        nvim_lsp[server].setup({
          capabilities = capabilities,
        })
      end,
      ["ts_ls"] = function()
        nvim_lsp["ts_ls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["gopls"] = function()
        nvim_lsp["gopls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["pyright"] = function()
        nvim_lsp["pyright"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["terraformls"] = function()
        nvim_lsp["terraformls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        nvim_lsp["lua_ls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })
  end,
}
