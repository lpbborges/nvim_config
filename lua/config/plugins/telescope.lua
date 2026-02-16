return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require "telescope"
        local builtin = require "telescope.builtin"

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

        local function get_git_root()
            local current_file_dir = vim.fn.expand "%:p:h"

            if current_file_dir == "" then
                return vim.fn.getcwd()
            end

            local git_dir = vim.fn.finddir(".git", current_file_dir .. ";")

            if git_dir ~= "" then
                return vim.fn.fnamemodify(git_dir, ":h")
            end

            return vim.fn.getcwd()
        end

        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
        vim.keymap.set("n", "<leader>fgi", builtin.git_files, { desc = "Git Files" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        vim.keymap.set("n", "<leader>en", function()
            builtin.find_files {
                cwd = vim.fn.stdpath "config",
            }
        end)
        vim.keymap.set("n", "<leader>ep", function()
            builtin.find_files {
                cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
            }
        end)
        vim.keymap.set("n", "<leader>pf", function()
            builtin.find_files { cwd = get_git_root() }
        end, { desc = "Find Files (Git Root)" })
        vim.keymap.set("n", "<leader>ps", function()
            builtin.live_grep { cwd = get_git_root() }
        end, { desc = "Grep (Git Root)" })

        require("config.telescope.multigrep").setup()
    end,
}
