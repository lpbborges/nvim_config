return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup {
            strategies = {
                chat = {
                    adapter = "ollama",
                },
                inline = {
                    adapter = "ollama",
                },
                agent = {
                    adapter = "ollama",
                },
            },
            adapters = {
                ollama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        env = {
                            url = "http://127.0.0.1:11434",
                        },
                        headers = {
                            ["Content-Type"] = "application/json",
                        },
                        parameters = {
                            sync = true,
                        },
                        schema = {
                            model = {
                                default = "qwen3-coder:30b",
                            },
                        },
                    })
                end,
            },
        }

        -- Recommended Keymaps
        vim.keymap.set(
            { "n", "v" },
            "<leader>cc",
            "<cmd>CodeCompanionChat Toggle<cr>",
            { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            "<cmd>CodeCompanionActions<cr>",
            { noremap = true, silent = true, desc = "CodeCompanion Actions" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<leader>ci",
            "<cmd>CodeCompanion<cr>",
            { noremap = true, silent = true, desc = "CodeCompanion Inline Prompt" }
        )
    end,
}
