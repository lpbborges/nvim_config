return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    keys = {
        { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        { "<leader>fG", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        { 
            "<leader>en", 
            function() 
                require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" } 
            end, 
            desc = "Browse Neovim Config" 
        },
        { 
            "<leader>ep", 
            function() 
                require("telescope.builtin").find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") } 
            end, 
            desc = "Browse Installed Plugins" 
        },
        { 
            "<leader>pf", 
            function()
                local function get_git_root()
                    local current_file_dir = vim.fn.expand "%:p:h"
                    if current_file_dir == "" then return vim.fn.getcwd() end
                    local git_dir = vim.fn.finddir(".git", current_file_dir .. ";")
                    if git_dir ~= "" then return vim.fn.fnamemodify(git_dir, ":h") end
                    return vim.fn.getcwd()
                end
                require("telescope.builtin").find_files { cwd = get_git_root() }
            end, 
            desc = "Find Files (Git Root)" 
        },
        { 
            "<leader>ps", 
            function()
                local function get_git_root()
                    local current_file_dir = vim.fn.expand "%:p:h"
                    if current_file_dir == "" then return vim.fn.getcwd() end
                    local git_dir = vim.fn.finddir(".git", current_file_dir .. ";")
                    if git_dir ~= "" then return vim.fn.fnamemodify(git_dir, ":h") end
                    return vim.fn.getcwd()
                end
                require("telescope.builtin").live_grep { cwd = get_git_root() }
            end, 
            desc = "Grep (Git Root)" 
        },
        { "<leader>fg", desc = "Multi Grep" },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require "telescope"

        telescope.setup {
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                },
            },
        }

        telescope.load_extension "fzf"

        require("config.telescope.multigrep").setup()
    end,
}
