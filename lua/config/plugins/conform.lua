return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                javascript = { "prettierd", "biome", stop_after_first = true },
                typescript = { "prettierd", "biome", stop_after_first = true },
                javascriptreact = { "prettierd", "biome", stop_after_first = true },
                typescriptreact = { "prettierd", "biome", stop_after_first = true },
                svelte = { "prettierd" },
                json = { "prettierd", "biome", stop_after_first = true },
                lua = { "stylua" },
                elixir = { "mix" },
                heex = { "mix" },
                eelixir = { "mix" },
                python = { "isort", "black" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,
        }
    end,
}
