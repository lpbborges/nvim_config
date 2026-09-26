local set = vim.opt

set.clipboard = "unnamedplus"
set.cmdheight = 1
set.completeopt = { "menuone", "noselect" }
set.colorcolumn = { "80", "120" }
set.conceallevel = 0
set.expandtab = true
set.guicursor:append "a:blinkon0"
set.guicursor:append "i-ci-ve:block-blinkon0"
set.hlsearch = false
set.ignorecase = true
set.inccommand = "split"
set.laststatus = 3
set.statusline = " %f %m%r %= %l:%c "

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

set.isfname:append "@-@"
set.shortmess:append "c"

set.foldlevel = 99
set.foldenable = true

local default_notify = vim.notify

vim.notify = function(msg, level, opts)
    if msg and msg:match "skipping file refresh due to debounce" then
        return
    end

    default_notify(msg, level, opts)
end
