return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                -- Biome for JavaScript ecosystem
                javascript = { "biome" },
                typescript = { "biome", "prettierd" },
                javascriptreact = { "biome" },
                typescriptreact = { "biome", "prettierd" },
                svelte = { "prettierd" },
                json = { "biome" },
                lua = { "stylua" },
                elixir = { "mix" },
                heex = { "mix" },
                eelixir = { "mix" }, -- For embedded Elixir in templates
                python = { "isort", "black" },
                -- Add trim_whitespace for other file types
                ["*"] = { "trim_whitespace" }, -- Apply to all other filetypes
            },
            -- Use a function to allow runtime toggling
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,
        }
    end,
}
