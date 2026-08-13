return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v1.*",
    event = "InsertEnter",
    opts = {
        keymap = { preset = "default" },
        appearance = {
            nerd_font_variant = "mono",
        },
        signature = { enabled = true },
        snippets = { preset = "default" },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                buffer = { min_keyword_length = 3 },
            },
        },
    },
}
