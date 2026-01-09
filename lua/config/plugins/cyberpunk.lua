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
            -- 1. Define the Palette
            local colors = {
                cyan   = "#00dede",
                green  = "#28fa86",
                white  = "#e4e4e4",
                grey   = "#5c6370",
                dark   = "#080a10",
                blue   = "#61afef",
                none   = "none"
            }

            -- 2. Helper function
            local function h(group, opts)
                vim.api.nvim_set_hl(0, group, opts)
            end

            -- 3. Base UI (Transparent Background)
            h("Normal",     { fg = colors.white, bg = colors.none })
            h("NormalNC",   { bg = colors.none })
            h("NormalFloat",{ fg = colors.white, bg = colors.none })
            h("FloatBorder",{ fg = colors.cyan,  bg = colors.none })
            h("SignColumn", { bg = colors.none })
            h("EndOfBuffer",{ bg = colors.none, fg = colors.grey })
            h("LineNr",     { fg = colors.grey,  bg = colors.none })
            h("CursorLine", { bg = "#1c1c1c" })
            h("CursorLineNr", { fg = colors.cyan, bold = true })

            -- 4. Popup Menu
            h("Pmenu",      { bg = "#11111b", fg = colors.white })
            h("PmenuSel",   { bg = "#2d2d3b", fg = colors.cyan, bold = true })
            h("PmenuBorder",{ fg = colors.grey, bg = "#11111b" })

            -- 5. Syntax Highlighting
            h("Statement",  { fg = colors.cyan, bold = true })
            h("Keyword",    { fg = colors.cyan, bold = true })
            h("Function",   { fg = colors.cyan })
            h("Directory",  { fg = colors.cyan, bold = true })
            h("Title",      { fg = colors.cyan, bold = true })

            h("String",     { fg = colors.green })
            h("Type",       { fg = colors.green })
            h("Boolean",    { fg = colors.green, bold = true })

            h("Comment",    { fg = colors.grey, italic = true })
            h("Constant",   { fg = colors.blue })
            h("Special",    { fg = colors.blue })
            h("Identifier", { fg = colors.white })
            h("PreProc",    { fg = colors.cyan })

            -- Diagnostics
            h("DiagnosticError", { fg = "#ff5555" })
            h("DiagnosticWarn",  { fg = "#f1fa8c" })
            h("DiagnosticInfo",  { fg = colors.cyan })
            h("DiagnosticHint",  { fg = colors.green })
        end
    }
}
