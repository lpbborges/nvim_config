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
    callback = function(args)
        if vim.bo[args.buf].filetype == "markdown" then
            return
        end
        if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
            return
        end
        local save_view = vim.fn.winsaveview()
        vim.cmd [[keeppatterns %s/\s\+$//e]]
        vim.fn.winrestview(save_view)
    end,
})

-- Netrw: safe C mapping that validates window number to prevent E16
-- Terminal escape sequences can produce huge v:count values, setting
-- g:netrw_chgwin to an invalid window number (e.g. 999999999).
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "netrw",
    callback = function()
        local opts = { buffer = true, silent = true }
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

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- reopen files at the last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function(args)
        if vim.bo[args.buf].filetype == "gitcommit" or vim.b[args.buf].restored_cursor then
            return
        end
        vim.b[args.buf].restored_cursor = true
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- keep splits balanced when the terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    callback = function()
        local tab = vim.api.nvim_get_current_tabpage()
        vim.cmd "tabdo wincmd ="
        vim.api.nvim_set_current_tabpage(tab)
    end,
})
