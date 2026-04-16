# Neovim Config Improvements Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add harpoon numbered navigation, LSP code actions, cleaner diagnostics, nvim-ts-autotag, and mini.statusline — without breaking the existing config.

**Architecture:** Pure config changes to existing Lua plugin specs and two new minimal plugin files. All changes are isolated to their respective plugin files. No shared state or cross-plugin dependencies introduced.

**Tech Stack:** Neovim 0.11+, lazy.nvim, Harpoon v2, nvim-lspconfig, nvim-ts-autotag, mini.statusline

---

### Task 1: Harpoon Numbered Navigation

**Files:**
- Modify: `lua/config/plugins/harpoon.lua`

**Step 1: Read current file**

Read `lua/config/plugins/harpoon.lua` to understand existing keymaps.

**Step 2: Add numbered jump keymaps**

Inside the `config = function()` block, after the existing keymaps, add:

```lua
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
```

**Step 3: Verify**

Launch Neovim, add a file with `<S-m>`, open the menu with `<TAB>`, close it, then press `<leader>1`. The file should open instantly.

**Step 4: Commit**

```bash
git add lua/config/plugins/harpoon.lua
git commit -m "feat(harpoon): add numbered navigation keymaps <leader>1-4"
```

---

### Task 2: LSP Code Actions Keymap

**Files:**
- Modify: `lua/config/plugins/mason.lua`

**Step 1: Read current file**

Read `lua/config/plugins/mason.lua` and locate the `LspAttach` callback block (around line 70).

**Step 2: Add code action keymap**

Inside the `LspAttach` callback, after the existing `map` calls, add:

```lua
map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
```

**Step 3: Verify**

Open a TypeScript file with an LSP warning (e.g., an unused import), position cursor on it, and press `<leader>ca`. A floating menu should appear with available actions.

**Step 4: Commit**

```bash
git add lua/config/plugins/mason.lua
git commit -m "feat(lsp): add code action keymap <leader>ca"
```

---

### Task 3: Diagnostic Virtual Lines

**Files:**
- Modify: `lua/config/plugins/mason.lua`

**Step 1: Locate diagnostic config**

In `lua/config/plugins/mason.lua`, find the `vim.diagnostic.config` block (around line 88). It currently has `virtual_text = true`.

**Step 2: Replace virtual_text with virtual_lines**

Change:
```lua
virtual_text = true,
```
To:
```lua
virtual_text = false,
virtual_lines = { current_line = true },
```

**Step 3: Verify**

Open a file with a diagnostic error. Move the cursor to the line with the error — a clean line should appear below it with the message. Move away — the line disappears. No more inline text crowding the end of lines.

**Step 4: Commit**

```bash
git add lua/config/plugins/mason.lua
git commit -m "feat(lsp): switch diagnostics to virtual_lines current_line"
```

---

### Task 4: nvim-ts-autotag

**Files:**
- Create: `lua/config/plugins/autotag.lua`

**Step 1: Create plugin file**

Create `lua/config/plugins/autotag.lua` with:

```lua
return {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
}
```

`opts = {}` triggers the default `setup()` call via lazy.nvim, which auto-detects supported filetypes from treesitter.

**Step 2: Verify**

Open a `.tsx` or `.jsx` file, type `<div` and press `>`. The closing `</div>` should be inserted automatically. Also test renaming: select an opening tag, rename it — the closing tag should update.

**Step 3: Commit**

```bash
git add lua/config/plugins/autotag.lua
git commit -m "feat(editor): add nvim-ts-autotag for JSX/HTML tag auto-close"
```

---

### Task 5: mini.statusline

**Files:**
- Create: `lua/config/plugins/statusline.lua`

**Step 1: Create plugin file**

Create `lua/config/plugins/statusline.lua` with:

```lua
return {
    "echasnovski/mini.statusline",
    version = "*",
    opts = { use_icons = false },
}
```

`use_icons = false` uses text labels (MODE, BRANCH, etc.) instead of nerd font glyphs, which avoids rendering issues and is more readable.

**Step 2: Verify**

Launch Neovim. The statusline at the bottom should now show: current mode, git branch (from gitsigns), filename, modified flag, diagnostic counts, filetype, and cursor position. It should update when you switch modes.

**Step 3: Commit**

```bash
git add lua/config/plugins/statusline.lua
git commit -m "feat(ui): add mini.statusline to fill global statusline"
```
