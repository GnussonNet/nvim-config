return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  config = function()
    require("mini.animate").setup({
      open = {
        enable = false,
      },
      close = {
        enable = false,
      }
    })
  end
}
