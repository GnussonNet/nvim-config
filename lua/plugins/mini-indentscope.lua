return {
  "echasnovski/mini.indentscope",
  event = "VeryLazy",

  version = false,
  config = function()
    require("mini.indentscope").setup({
      symbol = "│",
    })
  end,
}
