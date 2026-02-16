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
                "elixirls",
                "eslint",
                "html",
                "jsonls",
                "lua_ls",
                "tailwindcss",
                "ts_ls",
                "yamlls",
                "ruby_lsp",
            }
            require("mason-lspconfig").setup {
                ensure_installed = ensure_installed,
                handlers = {
                    function(server_name)
                        local capabilities = require("blink.cmp").get_lsp_capabilities()
                        local lspconfig = require "lspconfig"
                        local opts = {
                            capabilities = capabilities,
                        }

                        if server_name == "lua_ls" then
                            opts.settings = {
                                Lua = {
                                    diagnostics = { globals = { "vim" } },
                                    workspace = { checkThirdParty = false },
                                },
                            }
                        end

                        lspconfig[server_name].setup(opts)
                    end,
                },
                automatic_installation = true,
            }
        end,
    },
}
