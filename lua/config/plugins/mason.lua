return {
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        dependencies = {
            "mason-org/mason.nvim",
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
                return vim.fs.find(function(name)
                    return name:match "^%.eslintrc" ~= nil or name:match "^eslint%.config%." ~= nil
                end, { path = dir, upward = true })[1]
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

            -- LSP keymaps — buffer-local, set when a server attaches.
            -- K, grn, gra, grr, gri, grt, <C-s> (insert) come from Neovim's built-in
            -- 0.11+ defaults; only the Telescope-picker-backed variants are added here.
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local buf = args.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = buf, desc = desc })
                    end

                    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
                    map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
                    map("n", "<leader>vrr", vim.lsp.buf.references, "References")
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
