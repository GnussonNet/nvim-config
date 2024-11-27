return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = false,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    requires = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "eslint_d",
          "lua-language-server",
          "typescript-language-server",
          "tailwindcss-language-server",
          "html",
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          require("none-ls.diagnostics.eslint_d")
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })
      lspconfig.jdtls.setup({})
    end,
  },
  -- {
  --   "nvim-java/nvim-java",
  --   config = function()
  --     require("java").setup({
  --       jdk = {
  --         auto_install = false,
  --       }
  --     })
  --   end,
  -- }
}
