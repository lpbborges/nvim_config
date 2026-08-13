local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal
keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer (netrw)" })
keymap("n", "J", "mzJ`z", { desc = "Join lines and keep cursor" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
keymap("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap("n", "N", "Nzzzv", { desc = "Prev search result and center" })
keymap("n", "*", "*zz", { desc = "Search word under cursor and center" })
keymap("n", "#", "#zz", { desc = "Search word backwards and center" })
keymap("n", "g*", "g*zz", { desc = "Search word without boundary and center" })
keymap("n", "g#", "g#zz", { desc = "Search word backwards without boundary and center" })
keymap({ "n", "v" }, "<S-h>", "^", { desc = "Go to start of line" })
keymap({ "n", "v" }, "<S-l>", "g_", { desc = "Go to end of line" })
keymap("n", "Q", "<nop>")
keymap("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Next quickfix" })
keymap("n", "<C-p>", "<cmd>cprev<CR>", { desc = "Prev quickfix" })

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

-- Block to use arrow keys
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', opts)
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', opts)
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', opts)
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', opts)

keymap("n", "<leader><leader>x", function()
    vim.cmd "so"
end, { desc = "Source current file" })

keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

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
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Insert --
keymap("i", "<C-c>", "<Esc>", opts)

-- Visual Block --
-- greatest remap ever
keymap("x", "p", [["_dP]], { desc = "Paste without yanking" })
keymap("x", "g/", "<Esc>/\\%V", { desc = "Search inside visual selection" })

keymap("n", "<leader>gg", "<cmd>LazyGitCurrentFile<CR>", { desc = "LazyGit" })

-- Toggle auto-format on save
keymap("n", "<leader>tf", function()
    if vim.g.disable_autoformat then
        vim.g.disable_autoformat = false
        vim.notify("Auto-format on save: ON", vim.log.levels.INFO)
    else
        vim.g.disable_autoformat = true
        vim.notify("Auto-format on save: OFF", vim.log.levels.INFO)
    end
end, { desc = "Toggle auto-format on save" })
