vim.api.nvim_create_autocmd("FileType", {
    pattern = { "heex", "eelixir", "elixir" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.tabstop = 2
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.wrap = true
        vim.opt_local.breakindent = true
        vim.opt_local.linebreak = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = true
    end,
})
