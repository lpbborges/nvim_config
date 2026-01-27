return {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    init = function()
        vim.api.nvim_set_hl(0, "CodeiumSuggestion", { link = "Comment", default = true })
    end,
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
    end,
}
