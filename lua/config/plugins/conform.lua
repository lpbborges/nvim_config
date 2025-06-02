return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters = {
        -- Custom formatter for trimming trailing whitespace
        trim_whitespace = {
          command = "sed",
          args = { "-E", "s/[[:space:]]+$//g" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        -- Biome for JavaScript ecosystem
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        lua = { "stylua" },
        -- Add trim_whitespace for other file types
        ["*"] = { "trim_whitespace" }, -- Apply to all other filetypes
      },
    })
  end,
}
