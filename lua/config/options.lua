local set = vim.opt

set.backup = false
set.clipboard = "unnamedplus"
set.cmdheight = 1
set.completeopt = { "menuone", "noselect" }
set.colorcolumn = { "80", "120" }
set.conceallevel = 0
set.expandtab = true
set.fileencoding = "utf-8"
set.guicursor = "a:blinkon0"
set.hlsearch = false
set.ignorecase = true
set.incsearch = true
set.inccommand = "split"
set.laststatus = 3

set.number = true
set.pumheight = 10
set.relativenumber = true

set.scrolloff = 8
set.shiftwidth = 4
set.showcmd = false
set.sidescrolloff = 8
set.signcolumn = "yes"
set.smartcase = true
set.smartindent = true
set.softtabstop = 4
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 4
set.timeoutlen = 300
set.title = true
set.titlelen = 0
set.undodir = os.getenv "HOME" .. "/.vim/undodir"
set.undofile = true
set.updatetime = 250
set.whichwrap = "bs<>[]hl"
set.wrap = false
set.writebackup = false
set.autoread = true
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
})

-- pick up external edits (e.g. from an AI agent in another pane) on focus/buffer switch
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
    command = "checktime",
})
set.isfname:append "@-@"
set.shortmess:append "c"

set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldlevel = 99
set.foldenable = true

-- trim trailing whitespace on save (separate from conform)
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if not vim.g.disable_autoformat then
            local save_view = vim.fn.winsaveview()
            vim.cmd([[%s/\s\+$//e]])
            vim.fn.winrestview(save_view)
        end
    end,
})

local default_notify = vim.notify

vim.notify = function(msg, level, opts)
    if msg and msg:match "skipping file refresh due to debounce" then
        return
    end

    default_notify(msg, level, opts)
end

-- Netrw: safe C mapping that validates window number to prevent E16
-- Terminal escape sequences can produce huge v:count values, setting
-- g:netrw_chgwin to an invalid window number (e.g. 999999999).
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "C", function()
            local count = vim.v.count
            if count > 0 then
                if count > vim.fn.winnr("$") then
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
