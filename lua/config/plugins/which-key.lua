return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        spec = {
            { "<leader>b", group = "Buffer", icon = "󰓩 " },
            { "<leader>c", group = "Copy/Code", icon = "󰆏 " },
            { "<leader>e", group = "Edit", icon = " " },
            { "<leader>f", group = "Find/Telescope", icon = " " },
            { "<leader>g", group = "Git", icon = "󰊢 " },
            { "<leader>p", group = "Project", icon = "󰏖 " },
            { "<leader>t", group = "Toggle", icon = " " },
            { "<leader>v", group = "LSP/Diagnostics", icon = " " },
        },
    },
}
