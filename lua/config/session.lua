vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize"

-- Create sessions directory if it doesn't exist
local session_dir = vim.fn.stdpath("state") .. "/sessions/"
if vim.fn.isdirectory(session_dir) == 0 then
	vim.fn.mkdir(session_dir, "p")
end

local function get_session_file()
	local cwd = vim.fn.getcwd()
	local session_name = cwd:gsub("/", "%%")
	return session_dir .. session_name .. ".vim"
end

local function get_last_session_file()
	return session_dir .. "last_session.vim"
end

-- Track if nvim was started with input from stdin (e.g. `cmd | nvim`)
vim.api.nvim_create_autocmd("StdinReadPre", {
	callback = function()
		vim.g.started_with_stdin = true
	end,
})

-- Auto-restore session when starting with no arguments
vim.api.nvim_create_autocmd("VimEnter", {
	nested = true, -- Let BufRead/FileType etc. fire for restored buffers
	callback = function()
		-- Only restore if no files were specified
		if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
			local session_file = get_session_file()
			if vim.fn.filereadable(session_file) == 1 then
				vim.cmd("silent! set winminwidth=1 winwidth=1 winminheight=1 winheight=1")
				vim.cmd("source " .. vim.fn.fnameescape(session_file))
			end
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if vim.g.session_stop then
			return
		end

		-- Only save if we have actual file buffers (like persistence.nvim)
		local buf_count = 0
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if
				vim.bo[buf].buflisted
				and vim.bo[buf].buftype == ""
				and vim.api.nvim_buf_get_name(buf) ~= ""
			then
				buf_count = buf_count + 1
			end
		end

		local session_file = get_session_file()
		if buf_count >= 1 then -- Minimum 1 buffer (like persistence default)
			vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
			vim.cmd("mksession! " .. vim.fn.fnameescape(get_last_session_file()))
		else
			-- No files open anymore, remove stale session so it isn't restored
			vim.fn.delete(session_file)
		end
	end,
})

-- Load session for current directory
vim.keymap.set("n", "<leader>qs", function()
	local session_file = get_session_file()
	if vim.fn.filereadable(session_file) == 1 then
		vim.cmd("source " .. vim.fn.fnameescape(session_file))
	else
		print("No session found for current directory")
	end
end, { desc = "Load session for current directory" })

-- Load last session
vim.keymap.set("n", "<leader>ql", function()
	local last_session = get_last_session_file()
	if vim.fn.filereadable(last_session) == 1 then
		vim.cmd("source " .. vim.fn.fnameescape(last_session))
	else
		print("No last session found")
	end
end, { desc = "Load last session" })

-- Select and load a session
vim.keymap.set("n", "<leader>qS", function()
	local sessions = {}
	local session_files = vim.fn.glob(session_dir .. "*.vim", false, true)

	for _, file in ipairs(session_files) do
		if file ~= get_last_session_file() then
			local name = vim.fn.fnamemodify(file, ":t:r")
			name = name:gsub("%%", "/") -- Convert back from escaped path
			table.insert(sessions, name)
		end
	end

	if #sessions == 0 then
		print("No sessions found")
		return
	end

	vim.ui.select(sessions, {
		prompt = "Select session to load:",
	}, function(choice)
		if choice then
			local session_file = session_dir .. choice:gsub("/", "%%") .. ".vim"
			vim.cmd("source " .. vim.fn.fnameescape(session_file))
		end
	end)
end, { desc = "Select session to load" })

-- Stop session saving for this nvim instance
vim.keymap.set("n", "<leader>qd", function()
	vim.g.session_stop = true
	print("Session saving stopped")
end, { desc = "Stop session saving" })
