local opts = { noremap = true, remap = false }

-- Open netrw
vim.keymap.set("n", "<leader>nr", "<cmd>Ex<CR>", opts)

-- Jump between split panes
vim.keymap.set("n", "<leader>h", "<C-w>h", opts)
vim.keymap.set("n", "<leader>j", "<C-w>j", opts)
vim.keymap.set("n", "<leader>k", "<C-w>k", opts)
vim.keymap.set("n", "<leader>l", "<C-w>l", opts)

-- Copy into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", opts)
vim.keymap.set("n", "<leader>Y", "\"+Y", opts)
