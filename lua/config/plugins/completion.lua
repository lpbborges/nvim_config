return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v1.*",
    opts = {
        keymap = { preset = "default" },
        appearance = {
            use_nvim_cmp_as_default = true,
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
