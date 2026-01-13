return {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("codeium").setup({
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                key_bindings = {
                    accept = "<C-g>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
        })

        -- CUSTOM TOGGLE FUNCTION
        vim.keymap.set("n", "<leader>ct", function()

            if vim.g.codeium_enabled == true or vim.g.codeium_enabled == nil then
                vim.g.codeium_enabled = false
                vim.notify("Codeium Disabled", vim.log.levels.INFO)
            else
                vim.g.codeium_enabled = true
                vim.notify("Codeium Enabled", vim.log.levels.INFO)
            end
        end, { noremap = true, silent = true, desc = "Toggle Codeium" })
    end,
}
