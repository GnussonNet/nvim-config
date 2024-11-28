return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    require("notify").setup({
      background_colour = "#1e222a",
    })
  end
}
