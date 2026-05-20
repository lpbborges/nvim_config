return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        require("conform").setup {
            formatters = {
                prettier = {
                    require_cwd = true,
                    cwd = require("conform.util").root_file({
                        ".prettierrc",
                        ".prettierrc.json",
                        ".prettierrc.js",
                        ".prettierrc.yaml",
                        ".prettierrc.yml",
                        "prettier.config.js",
                        "package.json",
                    }),
                },
            },
            formatters_by_ft = {
                javascript = { "prettier", "biome", stop_after_first = true },
                typescript = { "prettier", "biome", stop_after_first = true },
                javascriptreact = { "prettier", "biome", stop_after_first = true },
                typescriptreact = { "prettier", "biome", stop_after_first = true },
                svelte = { "prettier" },
                json = { "prettier", "biome", stop_after_first = true },
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
