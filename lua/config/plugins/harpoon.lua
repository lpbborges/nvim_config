return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  keys = {
    { "<S-m>", "<CMD>lua require('config.plugins.harpoon').mark_file()<CR>" },
    { "<TAB>", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>" },
  },
  config = function()
    vim.api.nvim_create_autocmd({ "filetype" }, {
      pattern = "harpoon",
      callback = function()
        vim.cmd [[highlight link HarpoonBorder TelescopeBorder]]
      end,
    })
  end,
  mark_file = function()
    require("harpoon.mark").add_file()
  end,
}
