# nvim config

Personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim >= 0.10
- `git`, `make`, `ripgrep`
- A [Nerd Font](https://www.nerdfonts.com/) (config uses 0xProto)
- Node.js (for LSP servers installed via Mason)

## Structure

```
├── init.lua                     # Entry point
└── lua/config/
    ├── keymaps.lua              # Global keybindings
    ├── lazy.lua                 # Plugin manager bootstrap
    ├── options.lua              # Vim options
    ├── plugins/                 # One file per plugin
    └── telescope/
        └── multigrep.lua        # Custom multi-grep picker
```

## Plugins

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [neon-genesis](https://github.com/lpbborges/neon-genesis) | Colorscheme (custom) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) + mason-lspconfig | LSP server installer |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [Telescope](https://github.com/nvim-telescope/telescope.nvim) + fzf-native | Fuzzy finding |
| [Harpoon 2](https://github.com/ThePrimeagen/harpoon) | File bookmarking |
| [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) | Git decorations & hunk actions |
| [LazyGit](https://github.com/kdheepak/lazygit.nvim) | Git TUI |
| [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [Undotree](https://github.com/mbbill/undotree) | Undo history visualizer |
| [mini.statusline](https://github.com/echasnovski/mini.statusline) | Statusline |
| [autopairs](https://github.com/windwp/nvim-autopairs) + autotag | Auto-close brackets/tags |
| markdown-preview (custom, `glow`-based) | Live Markdown preview — see `after/plugin/markdown-preview.lua` |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua development (Neovim API types) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Leader-key hints/discoverability |

## LSP Servers

Installed automatically via Mason: `bashls`, `cssls`, `elixirls`, `eslint`, `html`, `jsonls`, `lua_ls`, `pyright`, `tailwindcss`, `ts_ls`, `yamlls`, `ruby_lsp`.

ESLint only activates when an `.eslintrc*` or `eslint.config.*` file is present in the project (`root_dir` resolver, see `lua/config/plugins/mason.lua`).

## Formatters

Managed by conform.nvim, installed via mason-tool-installer:

| Formatter | Languages |
|---|---|
| [prettierd](https://github.com/fsouza/prettierd) | JS, TS, JSX, TSX, JSON, Svelte (tried first) |
| [biome](https://biomejs.dev/) | JS, TS, JSX, TSX, JSON (fallback) |
| [stylua](https://github.com/JohnnyMorganz/StyLua) | Lua |
| `mix format` | Elixir, HEEx |
| [black](https://github.com/psf/black) + [isort](https://pycqa.github.io/isort/) | Python |

Auto-format on save is enabled by default and can be toggled at runtime.

## Key Mappings

Leader key: `<Space>`

### Navigation

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move between windows |
| `<S-h>` / `<S-l>` | Jump to line start / end |
| `<C-d>` / `<C-u>` | Scroll half-page (centered) |
| `<C-n>` / `<C-p>` | Next / prev quickfix item |
| `<leader>bb` | Switch to previous buffer |
| `<leader>pv` | Open file explorer (netrw) |

### Telescope

| Key | Action |
|---|---|
| `<leader>ff` | Find files (cwd) |
| `<leader>pf` | Find files (git root) |
| `<leader>fr` | Recent files |
| `<leader>fb` | Open buffers |
| `<leader>fG` | Git files |
| `<leader>fg` | Live multi-grep (pattern, then `  ` + glob) |
| `<leader>ps` | Live grep (git root) |
| `<leader>fd` | Workspace diagnostics |
| `<leader>en` | Browse Neovim config files |
| `<leader>ep` | Browse installed plugins |

### Harpoon

| Key | Action |
|---|---|
| `<leader>a` | Add file to Harpoon list |
| `<C-e>` | Toggle Harpoon menu |
| `<leader>1-4` | Jump to Harpoon file 1–4 |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `<C-h>` (insert) | Signature help |
| `<leader>vrr` | References |
| `<leader>vrn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>vd` | Open diagnostic float |
| `[d` / `]d` | Previous / next diagnostic |

### Git

| Key | Action |
|---|---|
| `<leader>gg` | Open LazyGit |
| `<leader>gb` | Toggle line blame |
| `<leader>gp` | Preview hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hS` / `<leader>hR` | Stage / reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hd` / `<leader>hD` | Diff this / diff HEAD |
| `]c` / `[c` | Next / prev git hunk |

### Editing

`clipboard = unnamedplus` is set, so plain `y`/`d`/`p` already use the system clipboard.

| Key | Action |
|---|---|
| `<leader>f` | Format buffer (or selection) |
| `<leader>tf` | Toggle auto-format on save |
| `<leader>d` | Delete to void register |
| `J` / `K` (visual) | Move selected lines down / up |
| `<` / `>` (visual) | Indent and stay in visual |
| `p` (visual block) | Paste without overwriting register |
| `<leader>u` | Toggle Undotree |


### Misc

| Key | Action |
|---|---|
| `<leader>cp` / `<leader>cP` | Copy relative / absolute file path |
| `<leader><leader>x` | Source current file |
| `g/` (visual) | Search inside selection |
