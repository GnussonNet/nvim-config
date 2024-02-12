vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Move lines
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Delete to void
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Show marker for 80 characters
vim.opt.colorcolumn = "80"

-- Neo tree
vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal toggle left<CR>")
vim.keymap.set("n", "<leader>g", ":Neotree git_status<CR>")
vim.keymap.set("n", "<leader>b", ":Neotree buffers<CR>")

-- LSP
vim.keymap.set("n", "<leader>n", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")
vim.keymap.set("n", "<leader>bw", ":Bdelete<CR>")
vim.keymap.set("n", "<leader>bW", ":bufdo Bdelete<CR>")

-- Windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- WIndows resize
vim.keymap.set("n", "<C-Left>", "<C-w><")
vim.keymap.set("n", "<C-Right>", "<C-w>>")
vim.keymap.set("n", "<C-Up>", "<C-w>+")
vim.keymap.set("n", "<C-Down>", "<C-w>-")

-- Terminal
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm size=20 direction=horizontal<cr>")
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
