local preview_buf = nil
local preview_win = nil
local source_buf = nil

local function close_preview()
    if preview_win and vim.api.nvim_win_is_valid(preview_win) then
        vim.api.nvim_win_close(preview_win, true)
    end
    if preview_buf and vim.api.nvim_buf_is_valid(preview_buf) then
        vim.api.nvim_buf_delete(preview_buf, { force = true })
    end
    preview_buf = nil
    preview_win = nil
    source_buf = nil
end

local function open_preview(filepath)
    close_preview()
    source_buf = vim.api.nvim_get_current_buf()

    vim.cmd("vsplit")
    preview_win = vim.api.nvim_get_current_win()
    preview_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(preview_win, preview_buf)

    -- Style the preview window
    vim.wo[preview_win].number = false
    vim.wo[preview_win].relativenumber = false
    vim.wo[preview_win].signcolumn = "no"
    vim.wo[preview_win].statusline = " Markdown Preview"

    -- Run glow in the terminal buffer
    vim.fn.termopen("glow -s dark " .. vim.fn.shellescape(filepath), {
        on_exit = function() end,
    })

    -- Return focus to the markdown buffer
    vim.cmd("wincmd p")
end

local function toggle_preview()
    local ft = vim.bo.filetype
    if ft ~= "markdown" then
        return
    end

    if preview_win and vim.api.nvim_win_is_valid(preview_win) then
        close_preview()
    else
        local filepath = vim.fn.expand("%:p")
        if filepath == "" then
            vim.notify("No file path — save the buffer first", vim.log.levels.WARN)
            return
        end
        open_preview(filepath)
    end
end

return {
    "nvim-lua/plenary.nvim",
    name = "markdown-preview",
    lazy = true,
    ft = "markdown",
    config = function()
        -- Keybind
        vim.keymap.set("n", "<leader>mp", toggle_preview, {
            desc = "Toggle markdown preview",
            silent = true,
        })

        -- Auto-refresh on save
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.md",
            callback = function()
                if preview_win and vim.api.nvim_win_is_valid(preview_win) then
                    if vim.api.nvim_get_current_buf() == source_buf then
                        open_preview(vim.fn.expand("%:p"))
                    end
                end
            end,
        })

        -- Clean up if preview window is closed manually
        vim.api.nvim_create_autocmd("WinClosed", {
            callback = function(args)
                if tonumber(args.match) == preview_win then
                    close_preview()
                end
            end,
        })
    end,
}
