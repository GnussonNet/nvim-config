local cmp_kinds = {
  Namespace = "󰌗",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󱓻",
  File = "󰈚",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Table = "",
  Object = "󰅩",
  Tag = "",
  Array = "[]",
  Boolean = "",
  Number = "",
  Null = "󰟢",
  Supermaven = "",
  String = "󰉿",
  Calendar = "",
  Watch = "󰥔",
  Package = "",
  Copilot = "",
  Codeium = "",
  TabNine = "",
  BladeNav = "",
}

return {
  {
    "hrsh7th/cmp-path",
    event = "InsertEnter",
  },
  {
    "onsails/lspkind.nvim",
    config = function()
      local lspkind = require("lspkind")
      lspkind.init({
        symbol_map = {
          Copilot = "",
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    version = "v2.*",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local kind = cmp.lsp.CompletionItemKind
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").load()

      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#0d1117", blend = 0 })
      vim.api.nvim_set_hl(0, "Pborder", { bg = "#0d1117", fg = "#3c4d6a", blend = 0 })
      vim.api.nvim_set_hl(0, "CmpDoc", { bg = "#0d1117", blend = 0 })
      vim.api.nvim_set_hl(0, "CmpDocBorder", { bg = "#0d1116", fg = "#3c4d6a", blend = 0 })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#000000", bg = "#5be56b" })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#000000", bg = "#925be5" })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#000000", bg = "#e55b5b" })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#000000", bg = "#ba74c7" })
      vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#000000", bg = "#c7cbd3" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#000000", bg = "#e55b5b" })
      -- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#000000", bg = "#5ba9e5" })
      vim.api.nvim_set_hl(0, "PmenuCursor", { fg = "#000000", bg = "#5ba9e5", bold = true })
      -- Make the foreground transparent
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#27435b" })

      cmp.setup({
        cmp_itemkind_reverse = true,
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local fmt = lspkind.cmp_format({
              -- with_text = false, -- hide kind beside the icon
              mode = "symbol_text",
              maxwidth = 100,
              minwidth = 70,
              ellipsis_char = "...",
            })(entry, item)

            local strings = vim.split(fmt.kind, "%s", { trimempty = true })

            fmt.kind = " " .. (cmp_kinds[strings[2]] or "") .. " "

            local entryItem = entry:get_completion_item()
            local color = entryItem.documentation

            if color and type(color) == "string" and color:match "^#%x%x%x%x%x%x$" then
              local hl = "hex-" .. color:sub(2)

              if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
                vim.api.nvim_set_hl(0, hl, { fg = color })
              end

              item.kind = " 󱓻 "
              item.kind_hl_group = hl
              -- item.menu_hl_group = hl
            end

            fmt.kind = fmt.kind .. " " -- just an extra space at the end
            fmt.menu = strings[2] ~= nil and ("   [" .. strings[2] .. "] (" .. entry.source.name .. ")") or ""

            return fmt
          end,
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered {
            border = 'single',
            winhighlight = 'Normal:Pmenu,FloatBorder:Pborder,Search:None,CursorLine:PmenuCursor',
            side_padding = 1,
          },
          documentation = cmp.config.window.bordered {
            border = "single",
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
            side_padding = 1,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping(function()
            if not cmp.confirm({ select = false }) then
              require("pairs.enter").type()
            end
          end),
        }),
        sources = cmp.config.sources({
          { name = "copilot",  group_index = 2 },
          { name = "buffer",   max_item_count = 5, group_index = 2 },
          { name = "path",     group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "luasnip",  group_index = 2 }, -- For luasnip users.
        }),
        experimental = {
          ghost_text = false,
        },
      })
      cmp.event:on("confirm_done", function(event)
        local item = event.entry:get_completion_item()
        local parensDisabled = item.data and item.data.funcParensDisabled or false
        if not parensDisabled and (item.kind == kind.Method or item.kind == kind.Function) then
          require("pairs.bracket").type_left("(")
        end
      end)
    end,
  },
}
