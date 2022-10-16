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

-- Enable 24-bit color
vim.o.termguicolors = true

-- Bootstrap packer
local packer_install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  print('bootstraping')
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', packer_install_path})
end

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'sainnhe/sonokai'
  use 'tanvirtin/monokai.nvim'
  
  -- Dependencies
  use 'nvim-lua/plenary.nvim' -- telescope, diffview
  use 'kyazdani42/nvim-web-devicons' -- telescope, lualine
  
  -- Status line
  use 'nvim-lualine/lualine.nvim'
  
  -- telescope
  use 'nvim-telescope/telescope.nvim'
  
  -- Autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  
  -- LSP
  use 'neovim/nvim-lspconfig'
  
  -- Rust
  use 'simrat39/rust-tools.nvim'
  
  -- Git diff
  use 'sindrets/diffview.nvim'

  -- If packer was just bootstraped install all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- -- Enable transparent background for buffers and lualine 
-- vim.g.sonokai_transparent_background = 2

-- -- Set theme to sonokai
-- vim.cmd("colorscheme sonokai")

-- Set theme to monokai
vim.api.nvim_create_autocmd('ColorScheme', { pattern = '*', command = "highlight normal ctermbg=none guibg=none" })
local monokai = require'monokai'
monokai.setup({ palette = monokai.pro })

-- Set up status line
local nvim_web_devicons = require'nvim-web-devicons'
nvim_web_devicons.setup()
local lualine = require'lualine'
-- lualine.setup({
--   options = {
--     theme = 'sonokai'
--   }
-- })
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

-- Set up Treesitter
local treesiter_configs = require'nvim-treesitter.configs'
treesiter_configs.setup {
  ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'json5', 'lua', 'proto', 'rust', 'sql', 'yaml' },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}

--[[ Enable this once https://github.com/nvim-telescope/telescope.nvim/issues/699 is fixed
vim.api.nvim_create_autocmd({'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end
})
]]--

-- Set up LSP
local on_attach = function(client, bufnr)
    local telescope_builtin = require'telescope.builtin'
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, bufopts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, bufopts)

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
