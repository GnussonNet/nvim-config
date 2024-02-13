return {
  'mawkler/modicator.nvim',
  config = function()
    require("modicator").setup({
      show_warnings = false,
    })
  end
}
