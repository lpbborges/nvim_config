local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove { "c", "r", "o" }
    end,
})

-- pick up external edits (e.g. from an AI agent in another pane) on focus/buffer switch
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
    group = augroup,
    callback = function()
        -- :checktime is not allowed in the command-line window (E11)
        if vim.fn.getcmdwintype() == "" then
            vim.cmd.checktime()
        end
    end,
})

-- trim trailing whitespace on save (separate from conform)
-- excludes markdown: two trailing spaces there are a hard line break
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "markdown" then
            return
        end
        if not vim.g.disable_autoformat then
            local save_view = vim.fn.winsaveview()
            vim.cmd [[keeppatterns %s/\s\+$//e]]
            vim.fn.winrestview(save_view)
        end
    end,
})

-- Netrw: safe C mapping that validates window number to prevent E16
-- Terminal escape sequences can produce huge v:count values, setting
-- g:netrw_chgwin to an invalid window number (e.g. 999999999).
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "netrw",
    callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "C", function()
            local count = vim.v.count
            if count > 0 then
                if count > vim.fn.winnr "$" then
                    vim.notify("Invalid window number: " .. count, vim.log.levels.ERROR)
                    return
                end
                vim.g.netrw_chgwin = count
            else
                vim.g.netrw_chgwin = vim.fn.winnr()
            end
            vim.notify("editing window now set to window#" .. vim.g.netrw_chgwin)
        end, opts)
    end,
})
