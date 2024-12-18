return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  keys = {
    { "<leader>vd",  function() vim.diagnostic.open_float() end },
    { "[d",          function() vim.diagnostic.goto_prev() end },
    { "]d",          function() vim.diagnostic.goto_next() end },
    { "K",           function() vim.lsp.buf.hover() end },
    { "gd",          function() vim.lsp.buf.definition() end },
    { "gD",          function() vim.lsp.buf.declaration() end },
    { "gi",          function() vim.lsp.buf.implementation() end },
    { "gt",          function() vim.lsp.buf.type_definition() end },
    { "<leader>vrr", function() vim.lsp.buf.references() end },
    { "<C-h>",       function() vim.lsp.buf.signature_help() end, mode = "i" },
    { "<leader>vrn", function() vim.lsp.buf.rename() end },
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require "lspconfig"
    lspconfig.lua_ls.setup { capabilities = capabilities }
    lspconfig.ts_ls.setup { capabilities = capabilities }
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "E",
          [vim.diagnostic.severity.WARN] = "W",
          [vim.diagnostic.severity.HINT] = "H",
          [vim.diagnostic.severity.INFO] = "I",
        }
      },
      virtual_text = true,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        header = "",
        prefix = "",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end
      end,
    })
  end,
}
