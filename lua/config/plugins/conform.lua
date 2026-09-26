return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true }, function(err)
                    if not err then
                        local mode = vim.api.nvim_get_mode().mode
                        if vim.startswith(string.lower(mode), "v") then
                            vim.api.nvim_feedkeys(vim.keycode "<Esc>", "n", true)
                        end
                    end
                end)
            end,
            mode = { "n", "v" },
            desc = "Format Code",
        },
    },
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
