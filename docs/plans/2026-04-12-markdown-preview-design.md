# Markdown Preview Design

**Date:** 2026-04-12

## Overview

Add a side-by-side markdown preview inside Neovim using the `glow` CLI renderer. A keybind toggles a vertical terminal split that displays the rendered markdown, updating on each save.

## Architecture

A single new plugin file `lua/config/plugins/markdown-preview.lua` with no external Neovim plugin dependency. `glow` is installed via mason-tools alongside existing tools.

## Components

### Plugin file: `lua/config/plugins/markdown-preview.lua`
- Toggle function: opens/closes a right vertical split (~50% width) containing a terminal buffer running `glow -s dark <current_file>`
- Autocmd on `BufWritePost *.md`: if preview split is open, kills the terminal job and restarts glow with the updated file
- Keybind `<leader>mp` registered only when buffer filetype is `markdown`

### Mason tools: `lua/config/plugins/mason-tools.lua`
- Add `glow` to the ensure_installed list

## Behavior

- `<leader>mp` toggles the preview split from any markdown buffer
- Split opens on the right as a vertical split at ~50% width
- Terminal buffer is read-only with no line numbers or statusline
- Preview auto-refreshes on save
- Closing the split manually works without special teardown
- Calling `<leader>mp` on a non-markdown buffer is a no-op

## Keybind

| Key | Mode | Action |
|-----|------|--------|
| `<leader>mp` | Normal | Toggle markdown preview split |
