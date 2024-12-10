return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason").setup {
        ui = {
          border = "rounded",
        },
      }
      require("mason-lspconfig").setup {
        ensure_installed = {
          "bashls",
          "cssls",
          "eslint",
          "html",
          "jsonls",
          "lua_ls",
          "tailwindcss",
          "ts_ls",
          "yamlls",
        }
      }
    end,
  }
}
