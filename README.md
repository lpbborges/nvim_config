# nvim config

Personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim >= 0.12 (uses the built-in undotree, `vim.treesitter.select` and `vim.lsp.config`)
- `git`, `make`, `ripgrep`, `tree-sitter` CLI (for nvim-treesitter `main`)
- A [Nerd Font](https://www.nerdfonts.com/) (config uses 0xProto)
- Node.js (for LSP servers installed via Mason)

## Structure

```
├── init.lua                     # Entry point
├── after/ftplugin/              # Per-filetype settings (elixir, heex, markdown, qf)
└── lua/config/
    ├── options.lua              # Vim options
    ├── keymaps.lua              # Global keybindings
    ├── autocmds.lua             # Global autocommands
    ├── lazy.lua                 # Plugin manager bootstrap
    ├── markdown_preview.lua     # glow-based markdown preview
    ├── plugins/                 # One file per plugin
    └── telescope/
        └── multigrep.lua        # Custom multi-grep picker
```

## Plugins

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [neon-genesis](https://github.com/lpbborges/neon-genesis) | Colorscheme (custom) |
| [mason.nvim](https://github.com/mason-org/mason.nvim) + mason-lspconfig + mason-tool-installer | LSP server / tool installer |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration (`plugins/lsp.lua`) |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [Telescope](https://github.com/nvim-telescope/telescope.nvim) + fzf-native | Fuzzy finding |
| [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) | Git decorations & hunk actions |
| [LazyGit](https://github.com/kdheepak/lazygit.nvim) | Git TUI |
| [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (`main`) | Highlighting, folds, indent for any filetype with a parser |
| [neotest](https://github.com/nvim-neotest/neotest) | Test runner (jest, vitest, rspec, minitest, elixir, pytest) |
| [autopairs](https://github.com/windwp/nvim-autopairs) + autotag | Auto-close brackets/tags |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua development (Neovim API types) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Leader-key hints/discoverability |
| Undotree (built-in, `nvim.undotree`) | Undo history visualizer |
| Markdown preview (custom, `glow`-based) | Preview in a split, refreshed on save |

## LSP Servers

Installed automatically via Mason: `bashls`, `cssls`, `elixirls`, `eslint`, `html`, `jsonls`, `lua_ls`, `pyright`, `tailwindcss`, `ts_ls`, `yamlls`, `ruby_lsp`.

ESLint only activates when an `.eslintrc*` or `eslint.config.*` file is present in the project (`root_dir` resolver in `lua/config/plugins/lsp.lua`).

Diagnostics show as signs, plus virtual text on the cursor line only.

## Formatters

Managed by conform.nvim, installed via mason-tool-installer:

| Formatter | Languages |
|---|---|
| [biome](https://biomejs.dev/) | JS, TS, JSX, TSX, JSON — in projects with `biome.json(c)` |
| [prettierd](https://github.com/fsouza/prettierd) | JS, TS, JSX, TSX, JSON — everywhere else; Svelte |
| [stylua](https://github.com/JohnnyMorganz/StyLua) | Lua |
| `mix format` | Elixir, HEEx |
| [black](https://github.com/psf/black) + [isort](https://pycqa.github.io/isort/) | Python |

Auto-format (and trailing-whitespace trim) on save is enabled by default. Toggle globally with `<leader>tf`, or per buffer with `:let b:disable_autoformat = 1`.

## Key Mappings

Leader key: `<Space>`

### Navigation

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move between windows |
| `<C-Arrows>` | Resize window |
| `<S-h>` / `<S-l>` | Jump to line start / end |
| `<C-d>` / `<C-u>` | Scroll half-page (centered) |
| `<leader>bb` | Switch to previous buffer |
| `<leader>pv` | Open file explorer (netrw) |

### Quickfix

| Key | Action |
|---|---|
| `<C-n>` / `<C-p>` | Next / prev quickfix item |
| `<leader>co` / `<leader>cc` / `<leader>cl` | Open / close / list quickfix |

### Telescope

| Key | Action |
|---|---|
| `<leader>ff` | Find files (cwd) |
| `<leader>pf` | Find files (git root) |
| `<leader>fr` | Recent files |
| `<leader>fb` | Open buffers |
| `<leader>fG` | Git files |
| `<leader>fg` | Live multi-grep (pattern, then `  ` + glob) |
| `<leader>fw` | Grep word under cursor / selection |
| `<leader>ps` | Live grep (git root) |
| `<leader>fs` | LSP document symbols |
| `<leader>fd` | Workspace diagnostics |
| `<leader>fm` | Marks |
| `<leader>fh` | Help tags |
| `<leader>f.` | Resume last picker |
| `<leader>en` | Browse Neovim config files |
| `<leader>ep` | Browse installed plugins |

### LSP

Mostly Neovim's built-in defaults:

| Key | Action |
|---|---|
| `gd` / `gD` | Go to definition / declaration |
| `grr` | References |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `grn` | Rename symbol |
| `gra` | Code action |
| `K` | Hover documentation |
| `<C-s>` (insert) | Signature help |
| `[d` / `]d` | Previous / next diagnostic |
| `<C-w>d` | Open diagnostic float |

### Git

| Key | Action |
|---|---|
| `<leader>gg` | Open LazyGit |
| `<leader>gb` | Toggle line blame |
| `<leader>hp` | Preview hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (or selection) |
| `<leader>hS` / `<leader>hR` | Stage / reset buffer |
| `<leader>hd` / `<leader>hD` | Diff this / diff HEAD |
| `]c` / `[c` | Next / prev git hunk |
| `ih` (operator/visual) | Select hunk text object |

### Tests (neotest)

| Key | Action |
|---|---|
| `<leader>tt` | Run nearest test |
| `<leader>tr` | Run test file |
| `<leader>ts` | Toggle summary |
| `<leader>to` / `<leader>tO` | Show output / toggle output panel |
| `<leader>tS` | Stop test |

### Editing

`clipboard = unnamedplus` is set, so plain `y`/`d`/`p` already use the system clipboard.

| Key | Action |
|---|---|
| `<leader>cf` | Format buffer (or selection) |
| `<leader>tf` | Toggle auto-format on save |
| `<leader>d` | Delete to void register |
| `J` / `K` (visual) | Move selected lines down / up |
| `<` / `>` (visual) | Indent and stay in visual |
| `p` (visual) | Paste without overwriting register |
| `<CR>` / `<BS>` | Expand / shrink treesitter selection (normal buffers only) |
| `<leader>u` | Toggle Undotree |

### Misc

| Key | Action |
|---|---|
| `<leader>mp` | Toggle markdown preview (markdown buffers) |
| `<leader>cp` / `<leader>cP` | Copy relative / absolute file path |
| `<leader><leader>x` | Source current file |
| `g/` (visual) | Search inside selection |

Also: yanked text is briefly highlighted, files reopen at the last cursor position, and splits rebalance when the terminal is resized.
