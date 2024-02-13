return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require('ts_context_commentstring').setup({})
    end
  },
  {
    "numToStr/Comment.nvim",
    dependacies = {
      "JoosepAlviste/nvim-ts-context-commentstring"
    },
    config = function()
      require("Comment").setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
    lazy = false,
  }
}
