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
                "vim",
                "vimdoc",
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

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                if ft == "" then return end
                local ok = pcall(vim.treesitter.start, buf)
                if not ok then
                    vim.treesitter.stop(buf)
                end
            end,
        })
    end,
}
