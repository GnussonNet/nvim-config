-- Startup commands
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd(":Gitsigns toggle_current_line_blame")
  end,
})

-- Hide the miniindent scope when opening certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Open dashboard when closing last buffer
vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePre *",
  group = "dashboard_on_empty",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)

    if name == "" then
      vim.cmd([[:Dashboard]])
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.py" },
  desc = "Auto-format Python files after saving",
  callback = function()
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(":silent !black --preview -q " .. fileName)
    vim.cmd(":silent !isort --profile black --float-to-top -q " .. fileName)
    vim.cmd(":silent !docformatter --in-place --black " .. fileName)
  end,
  group = autocmd_group,
})
