vim.filetype.add({
    extension = {
        heex = "heex",
        eex = "eex",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "python",
        "lua",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "html",
        "css",
        "scss",
        "json",
        "markdown",
        "heex",
        "eelixir",
        "elixir",
    },
    callback = function()
        local filetype = vim.bo.filetype

        if filetype == "python" then
            vim.opt_local.expandtab = true
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
            vim.opt_local.tabstop = 4
        elseif filetype == "lua" then
            vim.opt_local.expandtab = true
            vim.opt_local.shiftwidth = 4
            vim.opt_local.softtabstop = 4
            vim.opt_local.tabstop = 4
        elseif filetype == "heex" or filetype == "eelixir" then
            vim.treesitter.start()
            vim.opt_local.expandtab = true
            vim.opt_local.shiftwidth = 2
            vim.opt_local.softtabstop = 2
            vim.opt_local.tabstop = 2
        elseif filetype == "elixir" then
            vim.treesitter.start()
            vim.opt_local.expandtab = true
            vim.opt_local.shiftwidth = 2
            vim.opt_local.softtabstop = 2
            vim.opt_local.tabstop = 2
        elseif filetype == "markdown" then
            vim.opt_local.expandtab = true
            vim.opt_local.wrap = true
            vim.opt_local.breakindent = true
            vim.opt_local.linebreak = true
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = true
    end,
})