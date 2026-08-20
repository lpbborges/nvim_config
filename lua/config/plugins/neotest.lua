return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters for JS/TS, Ruby, Elixir, Python
        "nvim-neotest/neotest-jest",
        "marilari88/neotest-vitest",
        "olimorris/neotest-rspec",
        "zidhuss/neotest-minitest",
        "jfpedroza/neotest-elixir",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup {
            adapters = {
                require "neotest-jest" {
                    jestCommand = "npm test --",
                    env = { CI = true },
                    cwd = function(path)
                        return vim.fn.getcwd()
                    end,
                },
                require "neotest-vitest" {},
                require "neotest-rspec" {},
                require "neotest-minitest" {},
                require "neotest-elixir" {},
                require "neotest-python" {
                    runner = "pytest",
                },
            },
        }
    end,
    keys = {
        {
            "<leader>tt",
            function()
                require("neotest").run.run()
            end,
            desc = "Run Nearest Test",
        },
        {
            "<leader>tr",
            function()
                require("neotest").run.run(vim.fn.expand "%")
            end,
            desc = "Run Test File",
        },
        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle Test Summary",
        },
        {
            "<leader>to",
            function()
                require("neotest").output.open { enter = true }
            end,
            desc = "Show Test Output",
        },
        {
            "<leader>tO",
            function()
                require("neotest").output_panel.toggle()
            end,
            desc = "Toggle Test Output Panel",
        },
        {
            "<leader>tS",
            function()
                require("neotest").run.stop()
            end,
            desc = "Stop Test",
        },
    },
}
