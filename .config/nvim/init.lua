-- Enable current line number and relative numbers for surrounding lines
vim.o.number = true
vim.o.relativenumber = true

-- Set tabwidth to 4 spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Use local vim configs if they exist
vim.o.exrc = true

-- Keep unsaved buffers open in background
vim.o.hidden = true

-- Disable highlighting of search matches when not actively searching
vim.o.hlsearch = false

-- Disable text wrapping
vim.o.wrap = false

-- Disable swapfile creation
vim.o.swapfile = false
-- Investigate these for how history is handled
-- Apparently these below work great with the undotree plugin
-- vim.o.undodir='~/.vim/undodir'
-- vim.o.undofile

-- Begin scrolling text before reaching first/last line on screen
vim.o.scrolloff = 8

-- Show extra column for error indications and similar
vim.o.signcolumn = 'yes'

-- Enable searching through all subfolders of open directory
vim.o.path = vim.o.path .. ',**'

local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Theme
Plug 'sainnhe/sonokai'

-- Dependencies
Plug 'nvim-lua/plenary.nvim' -- telescope, diffview
Plug 'kyazdani42/nvim-web-devicons' -- telescope, lualine

-- Status line
Plug 'nvim-lualine/lualine.nvim'

-- telescope
Plug 'nvim-telescope/telescope.nvim'

-- Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

-- LSP
Plug 'neovim/nvim-lspconfig'

-- Rust
Plug 'simrat39/rust-tools.nvim'

-- Git diff
Plug 'sindrets/diffview.nvim'
vim.call('plug#end')

-- Set theme to sonokai
vim.cmd("colorscheme sonokai")

-- Set up status line
local nvim_web_devicons = require'nvim-web-devicons'
nvim_web_devicons.setup()
local lualine = require'lualine'
lualine.setup()

local telescope = require'telescope'
telescope.setup({
  pickers = {
    find_files = {
      hidden = true
    }
  }
})

-- Set up autocompletion
vim.o.completeopt= 'menuone,noinsert,noselect'

local cmp = require'cmp'
cmp.setup({
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- Set up LSP
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

    -- Format on write
    local format = function()
      vim.lsp.buf.formatting_sync(nil, 1000)
    end
    vim.api.nvim_create_autocmd('BufWritePre', { buffer = bufnr, callback = format})
end

-- rust
local rust_tools = require'rust-tools'
rust_tools.setup({
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
        procMacro = {
          enable = true
        }
      }
    }
  }
})

-- cpp
local clangd = require'lspconfig'.clangd
clangd.setup({
  on_attach = on_attach,
  cmd = { "clangd-12" }
})

-- Cargo run for rust files
local run_rust_setup = function()
  vim.api.nvim_buf_set_keymap('n', '<leader>r',
                              ":below 10sp \\| lcd %:h \\| terminal cargo run<CR>",
                              { noremap = true, silent = true })
end
vim.api.nvim_create_autocmd('FileType', { pattern = 'rust', callback = run_rust_setup })

-- diffview
local diffview = require'diffview'
diffview.setup()

-- Use space as leader key
vim.g.mapleader = " "

options = { noremap = true, silent = true }

-- Jump between split panes
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', options)
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', options)
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', options)
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', options)

-- Open terminal
vim.api.nvim_set_keymap('n', '<leader>t', ":below 10sp \\| terminal<CR>i", options)

-- Exit terminal mode using escape
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', options)

-- telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', options)
