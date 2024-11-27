return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VeryLazy",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      default_component_configs = {
        modified = {
          symbol = "",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- this can only be used in the git_status source
            renamed = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "󰎔",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        position = "right",
        mappings = {
          ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        }
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            --close on file open
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    })
  end,
}
