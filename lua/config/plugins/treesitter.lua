return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup {
            ensure_installed = {
                "bash",
                "c",
                "elixir",
                "heex",
                "html",
                "javascript",
                "lua",
                "markdown",
                "markdown_inline",
                "tsx",
                "typescript",
                "query",
                "svelte",
                "python",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        }
    end,
}
