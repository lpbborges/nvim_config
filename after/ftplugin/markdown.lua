vim.opt_local.expandtab = true
vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.linebreak = true

vim.keymap.set("n", "<leader>mp", function()
    require("config.markdown_preview").toggle()
end, { buffer = true, silent = true, desc = "Toggle markdown preview" })
