return {
  {
    "nvim-telescope/telescope.nvim",
    event = 'VeryLazy',
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = 'VeryLazy',
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
