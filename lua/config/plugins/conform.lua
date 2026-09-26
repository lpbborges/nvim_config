-- Projects with a biome config are formatted by biome; everything else by prettierd.
local function biome_or_prettierd(bufnr)
    if vim.fs.root(bufnr, { "biome.json", "biome.jsonc" }) then
        return { "biome" }
    end
    return { "prettierd" }
end

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
    opts = {
        formatters_by_ft = {
            javascript = biome_or_prettierd,
            typescript = biome_or_prettierd,
            javascriptreact = biome_or_prettierd,
            typescriptreact = biome_or_prettierd,
            json = biome_or_prettierd,
            svelte = { "prettierd" },
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
    },
}
