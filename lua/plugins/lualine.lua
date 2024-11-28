return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options =
      {
        disabled_filetypes = { 'dashboard', 'neo-tree' }
      },
    })
  end,
}
