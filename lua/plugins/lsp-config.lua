return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },

  config = function()
    local mason_servers = {
      "bashls",
      "cssls",
      "html",
      "jsonls",
      "lua_ls",
      "tailwindcss",
      "ts_ls",
    }

    local mason_tools = {
      "eslint_d",
      "prettierd",
      "stylua",
    }

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
    }

    require("mason").setup()

    require("mason-lspconfig").setup({
      automatic_installation = false,
      ensure_installed = mason_servers,
    })
    require("mason-tool-installer").setup({ ensure_installed = mason_tools })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("blink.cmp").get_lsp_capabilities({}, false)
    )

    -- 0.11 fix
    for server, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend(
        "force",
        {},
        capabilities,
        config.capabilities or {}
      )
      vim.lsp.config(server, config)
    end
  end,
}
