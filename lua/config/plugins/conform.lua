return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup {
            formatters = {
                -- Custom formatter for trimming trailing whitespace
                trim_whitespace = {
                    command = "sed",
                    args = { "-E", "s/[[:space:]]+$//g" },
                    stdin = true,
                },
            },
            formatters_by_ft = {
                -- Biome for JavaScript ecosystem
                javascript = { "biome" },
                typescript = { "biome", "prettierd" },
                javascriptreact = { "biome" },
                typescriptreact = { "biome" },
                svelte = { "prettierd" },
                json = { "biome" },
                lua = { "stylua" },
                elixir = { "mix" },
                heex = { "mix" },
                eelixir = { "mix" }, -- For embedded Elixir in templates
                -- Add trim_whitespace for other file types
                ["*"] = { "trim_whitespace" }, -- Apply to all other filetypes
            },
        }
    end,
}
