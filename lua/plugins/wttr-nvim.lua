return {
  'lazymaniac/wttr.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    location = 'gothenburg',
    format = 1,
    custom_format = '%C+%t+%p',
    units = "M",
    lang = "sv"
  },
  keys = {
    {
      '<leader>W',
      function()
        require('wttr').get_forecast()   -- show forecast for my location
      end,
      desc = 'Weather Forecast',
    },
  },
}
