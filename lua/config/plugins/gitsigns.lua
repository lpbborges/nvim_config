return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup {
            current_line_blame = true,

            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",

            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle Git Blame" })
                map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Git Hunk" })
                map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
                map("v", "<leader>hs", function()
                    gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Stage Selection" })
                map("v", "<leader>hr", function()
                    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Reset Selection" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
                map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
                map("n", "<leader>hD", function()
                    gs.diffthis "~"
                end, { desc = "Diff This (HEAD)" })
            end,
        }
    end,
}
