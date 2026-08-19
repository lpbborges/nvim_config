local ensure_installed = {
    "bash",
    "c",
    "eex",
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
    "ruby",
}

-- filetypes to start treesitter for (parser names above don't always match filetype names)
local filetypes = {
    "sh",
    "c",
    "elixir",
    "heex",
    "eelixir",
    "html",
    "javascript",
    "lua",
    "markdown",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "query",
    "svelte",
    "python",
    "ruby",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install(ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                vim.treesitter.start()
                vim.wo.foldmethod = "expr"
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
