local set = vim.opt

set.backup = false
set.breakindent = true
set.clipboard = "unnamedplus"
set.cmdheight = 1
set.completeopt = { "menuone", "noselect" }
set.colorcolumn = { "80", "120" }
set.conceallevel = 0
set.expandtab = true
set.fileencoding = "utf-8"
set.guicursor = "a:blinkon0"
set.guifont = "0xProto:h17"
set.hlsearch = false
set.ignorecase = true
set.incsearch = true
set.inccommand = "split"
set.laststatus = 3
set.linebreak = true
set.number = true
set.pumheight = 10
set.relativenumber = true
set.ruler = false
set.scrolloff = 0
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
set.termguicolors = true
set.timeoutlen = 300
set.title = true
set.titlelen = 0
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true
set.updatetime = 50
set.whichwrap = "bs<>[]hl"
set.wrap = false
set.writebackup = false
set.formatoptions:remove({ "c", "r", "o" })
set.isfname:append "@-@"
set.shortmess:append "c"
