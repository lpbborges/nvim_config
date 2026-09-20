return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
    },
    config = function()
        require("mason-tool-installer").setup {
            ensure_installed = {
                "biome",
                "prettierd",
                "stylua",
                "black",
                "isort",
                "glow",
            },
        }
    end,
}
