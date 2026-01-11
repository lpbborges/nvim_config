-- FILE: lua/config/plugins/cyberpunk.lua
return {
    {
        -- We point 'dir' to your config folder so Lazy knows it's local.
        -- We give it a 'name' so Lazy can identify it.
        dir = vim.fn.stdpath("config"),
        name = "cyberpunk-theme",
        lazy = false,
        priority = 1001,
        config = function()
            -- Palette
            local colors = {
                cyan   = "#00dede",
                green  = "#28fa86",
                white  = "#e4e4e4",
                grey   = "#5c6370",
                dark   = "#080a10",
                blue   = "#61afef",
                red    = "#ff5555",
                yellow = "#f1fa8c",
                purple = "#bd93f9",
                none   = "none"
            }

            vim.g.terminal_color_1 = colors.red
            vim.g.terminal_color_9 = colors.red

            local function h(group, opts)
                vim.api.nvim_set_hl(0, group, opts)
            end

            -- Base UI (Transparent Background)
            h("Normal",     { fg = colors.white, bg = colors.none })
            h("NormalNC",   { bg = colors.none })
            h("NormalFloat",{ fg = colors.white, bg = colors.none })
            h("FloatBorder",{ fg = colors.cyan,  bg = colors.none })
            h("SignColumn", { bg = colors.none })
            h("EndOfBuffer",{ bg = colors.none, fg = colors.grey })
            h("LineNr",     { fg = colors.grey,  bg = colors.none })
            h("CursorLine", { bg = "#1c1c1c" })
            h("CursorLineNr", { fg = colors.cyan, bold = true })

            -- Popup Menu
            h("Pmenu",      { bg = "#11111b", fg = colors.white })
            h("PmenuSel",   { bg = "#2d2d3b", fg = colors.cyan, bold = true })
            h("PmenuBorder",{ fg = colors.grey, bg = "#11111b" })

            -- Syntax Highlighting
            h("Statement",  { fg = colors.cyan, bold = true })
            h("Keyword",    { fg = colors.cyan, bold = true })
            h("Function",   { fg = colors.cyan })
            h("Directory",  { fg = colors.cyan, bold = true })
            h("Title",      { fg = colors.cyan, bold = true })
            h("Operator",   { fg = colors.cyan, bold = true })

            h("String",     { fg = colors.green })
            h("Type",       { fg = colors.green })
            h("Boolean",    { fg = colors.green, bold = true })

            h("Comment",    { fg = colors.grey, italic = true })
            h("Constant",   { fg = colors.blue })
            h("Special",    { fg = colors.blue })
            h("Identifier", { fg = colors.white })
            h("PreProc",    { fg = colors.cyan })

            -- Diagnostics
            h("DiagnosticError", { fg = colors.red })
            h("DiagnosticWarn",  { fg = colors.yellow })
            h("DiagnosticInfo",  { fg = colors.cyan })
            h("DiagnosticHint",  { fg = colors.green })

            -- Git & Diff
            h("DiffAdd",        { fg = colors.green, bg = colors.none })
            h("GitSignsAdd",    { fg = colors.green, bg = colors.none })
            h("DiffDelete",     { fg = colors.red,   bg = colors.none })
            h("GitSignsDelete", { fg = colors.red,   bg = colors.none })

            -- Changed = Yellow/Blue
            h("DiffChange",     { fg = colors.yellow,bg = colors.none })
            h("GitSignsChange", { fg = colors.yellow,bg = colors.none })
            h("DiffText",       { fg = colors.blue,  bg = colors.none, bold = true })

            -- Status Line & Separators
            h("StatusLine",   { bg = colors.none, fg = colors.white })
            h("StatusLineNC", { bg = colors.none, fg = colors.grey })
            h("WinSeparator", { fg = "#3e4452", bg = colors.none })

            h("LazyGitBorder", { fg = colors.cyan, bg = colors.none })
            h("LazyGitFloat",  { bg = colors.none })
        end
    }
}
