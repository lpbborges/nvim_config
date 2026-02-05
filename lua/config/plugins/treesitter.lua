return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                sync_install = true,
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
                    "typescript",
                    "vim",
                    "vimdoc",
                    "query",
                    "svelte",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                autopairs = { enable = true },
            }
        end,
    },
}
