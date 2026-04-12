# Markdown Preview Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add a `<leader>mp` keybind that toggles a side-by-side vertical terminal split showing the current markdown file rendered by `glow`.

**Architecture:** A single new plugin file handles the toggle function and a BufWritePost autocmd. `glow` is added to mason-tools so it installs automatically. No external Neovim plugin needed.

**Tech Stack:** Neovim Lua API, lazy.nvim, mason-tool-installer, `glow` CLI

---

### Task 1: Add `glow` to mason-tools

**Files:**
- Modify: `lua/config/plugins/mason-tools.lua:9-14`

**Step 1: Add `glow` to the ensure_installed list**

Edit `lua/config/plugins/mason-tools.lua` so the list reads:

```lua
ensure_installed = {
    "biome",
    "prettierd",
    "stylua",
    "black",
    "isort",
    "glow",
},
```

**Step 2: Verify the file looks correct**

Open the file and confirm `"glow"` is present in the list.

**Step 3: Commit**

```bash
git add lua/config/plugins/mason-tools.lua
git commit -m "feat(mason): add glow for markdown preview"
```

---

### Task 2: Create the markdown preview plugin

**Files:**
- Create: `lua/config/plugins/markdown-preview.lua`

**Step 1: Create the file with the toggle implementation**

```lua
local preview_buf = nil
local preview_win = nil

local function close_preview()
    if preview_win and vim.api.nvim_win_is_valid(preview_win) then
        vim.api.nvim_win_close(preview_win, true)
    end
    if preview_buf and vim.api.nvim_buf_is_valid(preview_buf) then
        vim.api.nvim_buf_delete(preview_buf, { force = true })
    end
    preview_buf = nil
    preview_win = nil
end

local function open_preview(filepath)
    close_preview()

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
        open_preview(vim.fn.expand("%:p"))
    end
end

return {
    "nvim-lua/plenary.nvim", -- dummy dep to satisfy lazy.nvim spec format
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
                    open_preview(vim.fn.expand("%:p"))
                end
            end,
        })

        -- Clean up if preview window is closed manually
        vim.api.nvim_create_autocmd("WinClosed", {
            callback = function(args)
                if tonumber(args.match) == preview_win then
                    preview_buf = nil
                    preview_win = nil
                end
            end,
        })
    end,
}
```

**Step 2: Verify lazy.nvim picks it up**

Since all plugins in `lua/config/plugins/` are auto-imported via `{ import = "config.plugins" }` in `lazy.lua`, no further registration is needed.

**Note on the dummy dep:** The plugin spec uses `"nvim-lua/plenary.nvim"` as a dummy first positional arg only to satisfy lazy.nvim's spec format. The real logic is in `config`. If you prefer a cleaner approach, you can use a `{ dir = false }` spec pattern or simply use `vim.filetype` autocmd instead — but this is the simplest working form.

**Step 3: Commit**

```bash
git add lua/config/plugins/markdown-preview.lua
git commit -m "feat(markdown): add side-by-side glow preview toggle"
```

---

### Task 3: Manual verification

**Step 1: Restart Neovim and run `:Lazy sync`**

This installs `glow` via mason-tool-installer. Wait for it to complete.

**Step 2: Open a markdown file**

```bash
nvim /tmp/test.md
```

Write some markdown content:
```markdown
# Hello

This is **bold** and _italic_.

- item 1
- item 2

```lua
print("code block")
```
```

**Step 3: Toggle the preview**

Press `<leader>mp` — a right vertical split should appear showing the glow-rendered markdown.

**Step 4: Test auto-refresh**

Save the file (`:w`) after adding more content — the preview should update.

**Step 5: Test toggle close**

Press `<leader>mp` again — the split should close.

**Step 6: Test non-markdown buffer**

Open a `.lua` file and press `<leader>mp` — nothing should happen.
