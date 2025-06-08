local setup_keymaps = function()
    --- A helper function to set keymaps with default options.
    ---@param mode string | string[] The Vim mode(s) for the mapping (e.g., "n", "i", {"n", "v"}).
    ---@param lhs string The key sequence (left-hand side of the mapping).
    ---@param rhs string | function The Lua function to execute (right-hand side of the mapping).
    local custom_keymaps = function(mode, lhs, rhs)
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        keymap(mode, lhs, rhs, opts)
    end

    -- Diagnostic keymaps
    custom_keymaps("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end)

    custom_keymaps("n", "[d", function()
        vim.diagnostic.jump { count = -1 }
    end)
    custom_keymaps("n", "]d", function()
        vim.diagnostic.jump { count = 1 }
    end)

    -- LSP keymaps
    custom_keymaps("n", "K", function()
        vim.lsp.buf.hover()
    end)
    custom_keymaps("n", "gd", function()
        vim.lsp.buf.definition()
    end)
    custom_keymaps("n", "gD", function()
        vim.lsp.buf.declaration()
    end)
    custom_keymaps("n", "gi", function()
        vim.lsp.buf.implementation()
    end)
    custom_keymaps("n", "gt", function()
        vim.lsp.buf.type_definition()
    end)
    custom_keymaps("n", "<leader>vrr", function()
        vim.lsp.buf.references()
    end)
    custom_keymaps("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end)
    custom_keymaps("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end)
end

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
                },
            },
        },
    },
    config = function()
        setup_keymaps()

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
        }

        local lspconfig = require "lspconfig"

        local servers = require("mason-lspconfig").get_installed_servers()

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        for _, server_name in ipairs(servers) do
            local server_opts = {
                capabilities = capabilities,
            }
            if server_name == "biome" then
                server_opts.cmd = { "biome", "lsp-proxy" }
                server_opts.root_dir = lspconfig.util.root_pattern("biome.json", "package.json")
                server_opts.single_file_support = false
            end

            if server_name ~= "lua_ls" then
                lspconfig[server_name].setup(server_opts)
            end
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end
                if client.supports_method "textDocument/formatting" then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            require("conform").format {
                                bufnr = args.buf,
                                id = client.id,
                            }
                        end,
                    })
                end
            end,
        })
    end,
}
