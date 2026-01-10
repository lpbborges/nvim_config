return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        require("conform").setup {
            formatters = {
                trim_whitespace = {
                    command = "sed",
                    args = { "-E", "s/[[:space:]]+$//g" },
                    stdin = true,
                },
            },
            formatters_by_ft = {
                javascript = { "biome" },
                typescript = { "biome", "prettierd" },
                javascriptreact = { "biome" },
                typescriptreact = { "biome", "prettierd" },
                svelte = { "prettierd" },
                json = { "biome" },
                lua = { "stylua" },
                elixir = { "mix" },
                heex = { "mix" },
                eelixir = { "mix" },
                -- Add trim_whitespace for other file types
                ["*"] = { "trim_whitespace" },
            },
            format_on_save = function(bufnr)
                local bufname = vim.api.nvim_buf_get_name(bufnr)

                if bufname:match("/kenlo/") then
                   return {
                        timeout_ms = 500,
                        formatters = { "trim_whitespace" },
                        lsp_fallback = false,
                    }
                end

                return {
                    timeout_ms = 500,
                    lsp_fallback = true,
                }
            end,
        }
    end,
}
