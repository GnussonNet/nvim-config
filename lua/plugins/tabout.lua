return {
  "abecodes/tabout.nvim",
  event = 'InsertEnter',
  config = function()
    require("tabout").setup({})
  end,
}
