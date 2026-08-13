return {
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup {
                ui = { border = "rounded" },
            }

            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })

            local function has_eslint_config(dir)
                if not dir or dir == "" then
                    return nil
                end
                local patterns = { ".eslintrc*", "eslint.config.*" }
                return vim.fs.find(patterns, { path = dir, upward = true })[1]
            end

            vim.lsp.config("eslint", {
                root_dir = function(bufnr, on_dir)
                    local cwd = vim.fn.getcwd()
                    local buf_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
                    local config_file = has_eslint_config(buf_dir) or has_eslint_config(cwd)
                    if config_file then
                        on_dir(vim.fs.dirname(config_file))
                    end
                end,
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = { workspace = { checkThirdParty = false } },
                },
            })

            vim.lsp.config("ruby_lsp", {
                cmd = { "bash", "-lc", "ruby-lsp" },
            })

            vim.lsp.config("tailwindcss", {
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
            })

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
