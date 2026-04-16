return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "saghen/blink.cmp",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    { path = vim.fn.stdpath "config" .. "/lua" },
                },
            },
        },
    },
    config = function()
        -- Diagnostic keymaps (global — don't need LSP attached)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { noremap = true, silent = true })
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump { count = -1 }
        end, { noremap = true, silent = true })
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump { count = 1 }
        end, { noremap = true, silent = true })

        -- LSP keymaps — set buffer-local only when an LSP attaches
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local buf = args.buf
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = buf, desc = desc })
                end

                map("n", "K", vim.lsp.buf.hover, "Hover")
                map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
                map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
                map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
                map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
                map("n", "<leader>vrr", vim.lsp.buf.references, "References")
                map("n", "<leader>vrn", vim.lsp.buf.rename, "Rename")
                map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help")
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
            virtual_text = true,
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
}
