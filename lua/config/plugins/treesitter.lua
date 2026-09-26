-- Parsers to install. Highlighting/folds/indent are enabled for any filetype
-- that has a parser available (installed here or bundled with Neovim).
local ensure_installed = {
    "bash",
    "c",
    "css",
    "diff",
    "eex",
    "elixir",
    "gitcommit",
    "heex",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "ruby",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install(ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
            callback = function(args)
                if not pcall(vim.treesitter.start, args.buf) then
                    return
                end
                vim.wo[0][0].foldmethod = "expr"
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                -- keep the ftplugin's indentexpr when there is no treesitter indent query
                local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if lang and vim.treesitter.query.get(lang, "indents") then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
