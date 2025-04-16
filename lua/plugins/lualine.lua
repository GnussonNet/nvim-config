return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = "",
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'dashboard' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename', 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress', 'location'},
        lualine_z = {
          { "os.date('%x %X')" },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {},
    })
  end,
}
