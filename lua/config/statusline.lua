local M = {}

local NONE = "NONE"
local palette = {
	bg0 = "#0d1117",
	bg1 = "#161b22",
	bg2 = "#21262d",
	fg = "#c9d1d9",
	muted = "#8b949e",
	green = "#3fb950",
	blue = "#58a6ff",
	cyan = "#39c5cf",
	purple = "#bc8cff",
	pink = "#db61a2",
	yellow = "#d29922",
	orange = "#f0883e",
	red = "#f85149",
}

-- Helper to issue highlight commands
local function hi(group, opts)
	local cmd = { "highlight!", group }
	if opts.guibg then
		table.insert(cmd, "guibg=" .. opts.guibg)
	end
	if opts.guifg then
		table.insert(cmd, "guifg=" .. opts.guifg)
	end
	if opts.gui then
		table.insert(cmd, "gui=" .. opts.gui)
	end
	vim.cmd(table.concat(cmd, " "))
end

hi("StatusLine", { guibg = NONE, guifg = NONE })
hi("StatusLineNC", { guibg = NONE, guifg = NONE })

hi("StatusModeNormal", { guibg = palette.blue, guifg = palette.bg0, gui = "bold" })
hi("StatusModeInsert", { guibg = palette.blue, guifg = palette.bg0, gui = "bold" })
hi("StatusModeVisual", { guibg = palette.purple, guifg = palette.bg0, gui = "bold" })
hi("StatusModeReplace", { guibg = palette.red, guifg = palette.bg0, gui = "bold" })
hi("StatusModeCommand", { guibg = palette.yellow, guifg = palette.bg0, gui = "bold" })
hi("StatusModeTerminal", { guibg = palette.cyan, guifg = palette.bg0, gui = "bold" })
hi("StatusModeOther", { guibg = palette.orange, guifg = palette.bg0, gui = "bold" })
hi("StatusModeToNorm", { guibg = NONE, guifg = palette.blue })

-- git
hi("StatusGit", { guibg = palette.bg2, guifg = palette.fg, gui = "bold" })
hi("StatusGitToNorm", { guibg = NONE, guifg = palette.pink })
hi("StatusDiffAdd", { guibg = NONE, guifg = palette.green, gui = "bold" })
hi("StatusDiffChange", { guibg = NONE, guifg = palette.yellow, gui = "bold" })
hi("StatusDiffDelete", { guibg = NONE, guifg = palette.red, gui = "bold" })

--file
hi("StatusFile", { guibg = NONE, guifg = NONE, gui = "bold" })
hi("StatusFileToNorm", { guibg = NONE, guifg = NONE })

hi("StatusLSP", { guibg = NONE, guifg = NONE, gui = "bold" })
hi("StatusLSPToNorm", { guibg = NONE, guifg = NONE })

hi("StatusErrorIcon", { guibg = NONE, guifg = palette.red, gui = "bold" })
hi("StatusWarnIcon", { guibg = NONE, guifg = palette.yellow, gui = "bold" })
hi("StatusInfoIcon", { guibg = NONE, guifg = palette.blue, gui = "bold" })
hi("StatusHintIcon", { guibg = NONE, guifg = palette.cyan })

hi("StatusBuffer", { guibg = palette.bg2, guifg = palette.fg })
hi("StatusType", { guibg = palette.bg2, guifg = palette.fg })
hi("StatusTypeToNorm", { guibg = NONE, guifg = NONE })
hi("StatusNorm", { guibg = NONE, guifg = NONE })
hi("StatusLocation", { guibg = palette.purple, guifg = palette.bg0 })
hi("StatusPercent", { guibg = palette.blue, guifg = palette.bg0, gui = "bold" })

local fn = vim.fn

local _diag_cache = {} -- [bufnr] -> { e=n, w=n, i=n, h=n }

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function(args)
		local buf = args.buf
		local sev = vim.diagnostic.severity
		local counts = vim.diagnostic.count(buf)
		_diag_cache[buf] = {
			e = counts[sev.ERROR] or 0,
			w = counts[sev.WARN] or 0,
			i = counts[sev.INFO] or 0,
			h = counts[sev.HINT] or 0,
		}
	end,
})

local _wc_state = { words = 0, timer = nil }

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, {
	callback = function()
		local ft = vim.bo.filetype
		if not (ft:match("md") or ft:match("markdown") or ft == "text") then
			return
		end
		if _wc_state.timer then
			_wc_state.timer:stop()
			_wc_state.timer:close()
		end
		_wc_state.timer = vim.defer_fn(function()
			_wc_state.timer = nil
			_wc_state.words = fn.wordcount().words or 0
		end, 500)
	end,
})

local _icon_cache = {} -- [bufnr] -> icon string

vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
	callback = function(args)
		_icon_cache[args.buf] = nil
	end,
})

-- Git repo/branch with caching - uses gitsigns buffer variables for performance
local function get_git_branch()
	local branch = vim.b.gitsigns_head
	if not branch or branch == "" then
		return ""
	end

	-- Get repo name from gitsigns status dict if available
	local gs = vim.b.gitsigns_status_dict
	if gs and gs.root then
		-- Extract repo name from the root path
		local repo_name = vim.fn.fnamemodify(gs.root, ":t")
		return repo_name .. "/" .. branch
	end

	return branch
end

local function build_git_diff()
	local gs = vim.b.gitsigns_status_dict or {}
	local added = gs.added or 0
	local changed = gs.changed or 0
	local removed = gs.removed or 0

	local diff_str = ""
	if added > 0 then
		diff_str = diff_str .. "%#StatusDiffAdd# " .. added .. " "
	end
	if changed > 0 then
		diff_str = diff_str .. "%#StatusDiffChange# " .. changed .. " "
	end
	if removed > 0 then
		diff_str = diff_str .. "%#StatusDiffDelete# " .. removed .. " "
	end

	-- reset to StatusLine for everything that follows
	return diff_str .. "%#StatusLine#"
end

-- Diagnostics symbols
local function get_diagnostics()
	local buf = vim.api.nvim_get_current_buf()
	local c = _diag_cache[buf] or {}
	local s = ""
	if (c.e or 0) > 0 then
		s = s .. "%#StatusErrorIcon# " .. c.e .. " "
	end
	if (c.w or 0) > 0 then
		s = s .. "%#StatusWarnIcon# " .. c.w .. " "
	end
	if (c.i or 0) > 0 then
		s = s .. "%#StatusInfoIcon# " .. c.i .. " "
	end
	if (c.h or 0) > 0 then
		s = s .. "%#StatusHintIcon# " .. c.h .. " "
	end

	-- reset to StatusLine for following text
	return s .. "%#StatusLine#"
end

-- File icon
local function get_file_icon()
	local bufnr = vim.api.nvim_get_current_buf()
	if _icon_cache[bufnr] ~= nil then
		return _icon_cache[bufnr]
	end

	local ok, icons = pcall(require, "nvim-web-devicons")
	if not ok then
		_icon_cache[bufnr] = ""
		return ""
	end
	local name = vim.api.nvim_buf_get_name(bufnr)
	local f = fn.fnamemodify(name, ":t")
	local e = fn.fnamemodify(name, ":e")
	local icon = icons.get_icon(f, e, { default = true })
	local result = icon and icon .. " " or ""
	_icon_cache[bufnr] = result
	return result
end

-- Word count & reading time
local function word_reading()
	local ft = vim.bo.filetype
	if ft:match("md") or ft:match("markdown") or ft == "text" then
		local w = _wc_state.words
		if w == 0 then
			return ""
		end
		return w .. "w " .. " " .. math.ceil(w / 200) .. "m"
	end
	return ""
end

local mode_map = {
	n = { label = " NORMAL", hl = "StatusModeNormal" },
	i = { label = " INSERT", hl = "StatusModeInsert" },
	v = { label = " VISUAL", hl = "StatusModeVisual" },
	V = { label = " V-LINE", hl = "StatusModeVisual" },
	[""] = { label = " V-BLOCK", hl = "StatusModeVisual" },
	R = { label = " REPLACE", hl = "StatusModeReplace" },
	c = { label = " COMMAND", hl = "StatusModeCommand" },
	t = { label = " TERMINAL", hl = "StatusModeTerminal" },
	s = { label = " SELECT", hl = "StatusModeVisual" },
	S = { label = " S-LINE", hl = "StatusModeVisual" },
	[""] = { label = " S-BLOCK", hl = "StatusModeVisual" },
	r = { label = " PROMPT", hl = "StatusModeOther" },
	["!"] = { label = " SHELL", hl = "StatusModeOther" },
}

local function get_mode_info()
	local mode = vim.api.nvim_get_mode().mode
	local key = mode:sub(1, 1)
	local info = mode_map[key]
	if info then
		return info
	end
	return { label = " " .. mode:upper(), hl = "StatusModeOther" }
end

-- 4) Build statusline
function M.build()
	local st = ""

	-- A: mode
	local mode_info = get_mode_info()
	st = st .. "%#" .. mode_info.hl .. "# " .. mode_info.label .. " " .. "%#StatusModeToNorm#"

	-- B: git
	local br = get_git_branch()
	if br ~= "" then
		st = st .. "%#StatusGit# " .. " " .. br .. " " .. "%#StatusGitToNorm#"

		local git_diff = build_git_diff()
		if git_diff ~= "" then
			st = st .. git_diff .. "%#StatusGitToNorm#"
		end
	end

	-- C: filename
	-- local fnm = fn.expand("%:t")
	local fnm = fn.expand("%:.")
	if fnm ~= "" then
		st = st .. "%#StatusFile# " .. fnm .. " " .. (vim.bo.modified and " " or "") .. "%#StatusFileToNorm#"
	end

	local di = get_diagnostics()
	if di ~= "" then
		st = st .. "%#StatusLSP# " .. di .. " " .. "%#StatusLSPToNorm#"
	end

	-- right align
	st = st .. "%="

	-- X: filetype
	local ft = vim.bo.filetype
	if ft ~= "" then
		st = st .. "%#StatusType# " .. get_file_icon() .. ft .. "%#StatusTypeToNorm#"
	end

	-- Y: word/reading
	local wr = word_reading()
	if wr ~= "" then
		st = st .. "%#StatusBuffer# " .. " " .. wr
	end

	-- Z: encoding, format, location, percent
	st = st
		.. "%#StatusBuffer# "
		.. vim.bo.fileencoding
		.. " "
		.. vim.bo.fileformat
		.. " "
		.. "%#StatusLocation# %l:%c "
		.. "%#StatusPercent# %p%% "

	return st
end

vim.opt.laststatus = 3 -- global statusline
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.o.statusline = "%!v:lua.require('config.statusline').build()"
vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

return M
