local builtin = require('telescope.builtin')

local opts = { noremap = true, remap = false }
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
-- TODO: Figure out the best mapping for this one
-- vim.keymap.set('n', '<leader>f?', builtin.git_files, opts)
