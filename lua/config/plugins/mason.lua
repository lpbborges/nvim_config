return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup {
                ui = { border = "rounded" },
            }

            require("mason-lspconfig").setup {
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "elixirls",
                    "eslint",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "tailwindcss",
                    "ts_ls",
                    "yamlls",
                    "ruby_lsp",
                },
                handlers = {
                    function(server_name)
                        local capabilities = require("blink.cmp").get_lsp_capabilities()
                        require("lspconfig")[server_name].setup { capabilities = capabilities }
                    end,
                    ["eslint"] = function()
                        local function has_eslint_config(dir)
                            if not dir or dir == "" then return nil end
                            local Patterns = { ".eslintrc*", "eslint.config.*", ".eslintrc" }
                            return vim.fs.find(Patterns, { path = dir, upward = true })[1]
                        end

                        local cwd = vim.fn.getcwd()
                        local current_file = vim.api.nvim_buf_get_name(0)
                        local buf_dir = current_file ~= "" and vim.fs.dirname(current_file) or ""
                        local has_config = has_eslint_config(cwd) or has_eslint_config(buf_dir)

                        if has_config then
                            require("lspconfig").eslint.setup {
                                capabilities = require("blink.cmp").get_lsp_capabilities(),
                            }
                        end
                    end,
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup {
                            capabilities = require("blink.cmp").get_lsp_capabilities(),
                            settings = {
                                Lua = { workspace = { checkThirdParty = false } },
                            },
                        }
                    end,
                    ["tailwindcss"] = function()
                        require("lspconfig").tailwindcss.setup {
                            capabilities = require("blink.cmp").get_lsp_capabilities(),
                            filetypes = {
                                "html",
                                "css",
                                "scss",
                                "javascript",
                                "javascriptreact",
                                "typescript",
                                "typescriptreact",
                                "svelte",
                                "elixir",
                                "heex",
                            },
                            init_options = {
                                userLanguages = { heex = "html", elixir = "html" },
                            },
                        }
                    end,
                },
            }

            -- Diagnostic keymaps (global — work without an attached LSP)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { noremap = true, silent = true })
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump { count = -1 }
            end, { noremap = true, silent = true })
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump { count = 1 }
            end, { noremap = true, silent = true })

            -- LSP keymaps — buffer-local, set when a server attaches
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local buf = args.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = buf, desc = desc })
                    end

                    map("n", "K", vim.lsp.buf.hover, "Hover")
                    map("n", "gd", require("telescope.builtin").lsp_definitions, "Go to Definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
                    map("n", "gi", require("telescope.builtin").lsp_implementations, "Go to Implementation")
                    map("n", "gt", require("telescope.builtin").lsp_type_definitions, "Go to Type Definition")
                    map("n", "<leader>vrr", require("telescope.builtin").lsp_references, "References")
                    map("n", "<leader>vrn", vim.lsp.buf.rename, "Rename")
                    map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    map("v", "<leader>ca", vim.lsp.buf.code_action, "Code Action (range)")
                end,
            })

            vim.diagnostic.config {
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "E",
                        [vim.diagnostic.severity.WARN] = "W",
                        [vim.diagnostic.severity.HINT] = "H",
                        [vim.diagnostic.severity.INFO] = "I",
                    },
                },
                virtual_text = false,
                virtual_lines = false,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    header = "",
                    prefix = "",
                },
            }
        end,
    },
}
