local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal
keymap("n", "<leader>pv", vim.cmd.Ex)
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
keymap({ "n", "v" }, "<S-h>", "^", opts)
keymap({ "n", "v" }, "<S-l>", "g_", opts)
keymap("n", "Q", "<nop>")
keymap("n", "<C-n>", "<cmd>cnext<CR>", opts)
keymap("n", "<C-p>", "<cmd>cprev<CR>", opts)

keymap({ "x", "v", "n" }, "<leader>f", function()
    require("conform").format({ async = true }, function(err)
        if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
        end
    end)
end, { desc = "Format code" })

keymap("n", "<leader>Ao", ":AiderOpen --no-auto-commits<CR>", { noremap = true, silent = true })
keymap("n", "<leader>Am", ":AiderAddModifiedFiles<CR>", { noremap = true, silent = true })

-- Block to use arrow keys
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', opts)
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', opts)
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', opts)
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', opts)

keymap("n", "<leader><leader>x", function()
    vim.cmd "so"
end)

-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])
keymap({ "n", "v" }, "<leader>d", [["_d]])

keymap("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Switch to previous buffer" })

-- better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- resize window
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

keymap("n", "<leader>cp", function()
    local path = vim.fn.expand "%"
    vim.fn.setreg("+", path)
    vim.notify("Copied relative path: " .. path)
end, { desc = "Copy Relative Path" })

keymap("n", "<leader>cP", function()
    local path = vim.fn.expand "%:p"
    vim.fn.setreg("+", path)
    vim.notify("Copied absolute path: " .. path)
end, { desc = "Copy Absolute Path" })

-- Visual --
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Insert --
keymap("i", "<C-c>", "<Esc>", opts)

-- Visual Block --
-- greatest remap ever
keymap("x", "p", [["_dP]])
keymap("x", "g/", "<Esc>/\\%V", { desc = "Search inside visual selection" })

keymap("n", "<leader>gg", "<cmd>LazyGitCurrentFile<CR>", { desc = "LazyGit" })
