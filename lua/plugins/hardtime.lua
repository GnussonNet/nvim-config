return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("hardtime").setup({
      disabled_filetypes = {
        "qf",
        "netrw",
        "neo-tree",
        "neo-tree-popup",
        "lazy",
        "mason",
        "dashboard" },
    })
  end
}
