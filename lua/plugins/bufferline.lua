return {
  "akinsho/bufferline.nvim",
  event = "VimEnter",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "",
            separator = false,
            text_align = "center",
          },
        },
        diagnostics = "nvim_lsp",
        separator_style = { "", "" },
        modified_icon = "●",
        show_close_icon = false,
        show_buffer_close_icons = false,
      },
    })
  end,
}
