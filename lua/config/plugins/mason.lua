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
                "stylua"
            }
            require("mason-lspconfig").setup {
                ensure_installed = ensure_installed,
                handlers = {
                    function(server_name)
                        local capabilities = require("blink.cmp").get_lsp_capabilities()
                        local lspconfig = require "lsp_config"
                        local opts = {
                            capabilities = capabilities,
                        }

                        if server_name == "biome" then
                            opts.cmd = { "biome", "lsp-proxy" }
                            opts.root_dir = lspconfig.util.root_pattern("biome.json", "package.json")
                            opts.single_file_support = false
                        end

                        lspconfig[server_name].setup(opts)
                    end,
                    ["lua_ls"] = function() end,
                },
                automatic_installation = true,
            }
        end,
    },
}
