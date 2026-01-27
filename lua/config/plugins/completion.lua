return {
    {
        "saghen/blink.cmp",
        dependencies = "rafamadriz/friendly-snippets",
        version = "v0.*",
        opts = {
            keymap = { preset = "default" },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            signature = { enabled = true },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
                providers = {
                    codecompanion = {
                        name = "CodeCompanion",
                        module = "codecompanion.providers.completion.blink",
                        enabled = true,
                        score_offset = 100,
                    },
                },
                min_keyword_length = 3,
            },
        },
    },
}
