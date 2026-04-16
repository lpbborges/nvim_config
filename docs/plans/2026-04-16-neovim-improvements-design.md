# Neovim Config Improvements — Design

**Date:** 2026-04-16  
**Status:** Approved

## Summary

Three config-only fixes and two lightweight new plugins to improve daily TypeScript/JS and Elixir workflows without meaningful performance impact.

---

## Section 1: Config-Only Changes

### 1. Harpoon Numbered Navigation

**File:** `lua/config/plugins/harpoon.lua`

Add `<leader>1`–`<leader>4` keymaps to jump directly to harpoon list slots. The current config only binds add and menu toggle — direct slot navigation is harpoon's core productivity feature and is missing.

```lua
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
```

### 2. LSP Code Actions Keymap

**File:** `lua/config/plugins/mason.lua` — inside `LspAttach` callback

Add `<leader>ca` for `vim.lsp.buf.code_action`. Essential for TS (import missing symbol, add annotation) and Elixir (apply credo suggestions).

```lua
map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
```

### 3. Diagnostic Virtual Lines

**File:** `lua/config/plugins/mason.lua` — `vim.diagnostic.config`

Switch from inline virtual text to current-line virtual lines for cleaner diagnostic display on long lines.

```lua
virtual_text = false,
virtual_lines = { current_line = true },
```

---

## Section 2: New Plugins

### 4. nvim-ts-autotag

**New file:** `lua/config/plugins/autotag.lua`

Auto-closes and renames JSX, TSX, HTML, and Heex tags on insert. Treesitter-powered (treesitter already installed), zero runtime cost outside of supported filetypes. No keymaps needed.

```lua
return {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
}
```

### 5. mini.statusline

**New file:** `lua/config/plugins/statusline.lua`

Fills the global statusline (`laststatus=3` already set). Standalone install from `echasnovski/mini.statusline`. Integrates with gitsigns (already present) for git branch display. Shows: mode, git branch, filename+modified, diagnostics, filetype, position.

```lua
return {
    "echasnovski/mini.statusline",
    version = "*",
    opts = { use_icons = false },
}
```

`use_icons = false` avoids nerd font dependency issues; text labels are clear and unambiguous.

---

## Files Touched

| File | Action |
|---|---|
| `lua/config/plugins/harpoon.lua` | Edit — add 4 keymaps |
| `lua/config/plugins/mason.lua` | Edit — add code action keymap + update diagnostic config |
| `lua/config/plugins/autotag.lua` | Create |
| `lua/config/plugins/statusline.lua` | Create |
