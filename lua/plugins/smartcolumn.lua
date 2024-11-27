return {
  "m4xshen/smartcolumn.nvim",
  event = 'VeryLazy',
  config = function()
    require("smartcolumn").setup({
      disabled_filetypes = {
        "neo-tree",
        "dashboard",
        "lazy",
        "mason",
        "help",
        "checkhealth",
        "lspinfo",
      }
    })
  end
}
