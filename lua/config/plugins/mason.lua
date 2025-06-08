return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason").setup {
                ui = {
                    border = "rounded",
                },
            }
            local ensure_installed = {
                "bashls",
                "cssls",
                "eslint",
                "html",
                "jsonls",
                "lua_ls",
                "tailwindcss",
                "ts_ls",
                "yamlls",
                "ruby_lsp",
                "elixirls",
            }
            require("mason-lspconfig").setup {
                ensure_installed = ensure_installed,
            }
        end,
    },
}
