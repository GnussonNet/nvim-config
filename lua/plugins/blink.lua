vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
})

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
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#000000", bg = "#5ba9e5" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#000000", bg = "#5ba9e5" })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#000000", bg = "#5ba9e5" })
vim.api.nvim_set_hl(0, "PmenuCursor", { fg = "#000000", bg = "#5ba9e5", bold = true })
-- Make the foreground transparent
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#27435b" })

-- Lazy load on first insert mode entry
local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = { preset = "super-tab" },
			appearance = {
      kind_icons = cmp_kinds,
      nerd_font_variant = "mono",
				use_nvim_cmp_as_default = true,
			},
			completion = {
				documentation = {
          auto_show = false,
        },
        menu = {
          border = 'single',
          winhighlight = 'Normal:Pmenu,FloatBorder:Pborder,Search:None,CursorLine:PmenuCursor',
          auto_show = true,
          draw = {
            columns = {
              { "kind_icon"},
              { "label", "label_description", gap = 1 },
              { "source_name" }
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  return " " .. icon .. " "
                end,
                highlight = function(ctx)
                  return "CmpItemKind" .. ctx.kind
                end,
              },
            },
          }
        },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})
