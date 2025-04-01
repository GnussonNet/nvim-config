return {
  'kosayoda/nvim-lightbulb',
  event = "BufEnter",
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
    })
  end
}
