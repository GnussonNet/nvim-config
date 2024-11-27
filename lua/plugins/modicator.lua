return {
  'mawkler/modicator.nvim',
  event = "VeryLazy",
  config = function()
    require("modicator").setup({
      show_warnings = false,
    })
  end
}
