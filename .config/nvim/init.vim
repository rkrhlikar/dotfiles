" Disable vim compatibility
set nocompatible

" Enable current line number and relative numbers for surrounding lines
set number
set relativenumber

" Set tabwidth to 4 spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Use local vim configs if they exist
set exrc

" Keep unsaved buffers open in background
set hidden

" Disable highlighting of search matches when not actively searching
set nohlsearch

" Disable text wrapping
set nowrap

" Disable swapfile creation
set noswapfile
" Investigate these for how history is handled
" Apparently these below work great with the undotree plugin
" set undodir=~/.vim/undodir
" set undofile

" Begin scrolling text before reaching first/last line on screen
set scrolloff=8

" Show extra column for error indications and similar
set signcolumn=yes

" Enable searching through all subfolders of open directory
set path+=**

call plug#begin()
" Theme
Plug 'sainnhe/sonokai'

" Dependencies
Plug 'nvim-lua/plenary.nvim' " telescope, diffview
Plug 'kyazdani42/nvim-web-devicons' " telescope, lualine

" Status line
Plug 'nvim-lualine/lualine.nvim'

" telescope
Plug 'nvim-telescope/telescope.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" LSP
Plug 'neovim/nvim-lspconfig'

" Rust
Plug 'simrat39/rust-tools.nvim'

" Git diff
Plug 'sindrets/diffview.nvim'
call plug#end()

" Set theme to sonokai
colorscheme sonokai

" Set up status line
lua require("nvim-web-devicons").setup()
lua require("lualine").setup()

lua <<EOF
local telescope = require'telescope'
telescope.setup({
  pickers = {
    find_files = {
      hidden = true
    }
  }
})
EOF

" Set up autocompletion
set completeopt=menuone,noinsert,noselect

lua <<EOF
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
EOF

" Set up LSP
lua <<EOF
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

    -- Format on write
    vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]])
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
local clangd = require'lspconfig'.clangd;
clangd.setup({
  on_attach = on_attach,
  cmd = { "clangd-12" }
})
EOF

" Cargo run for rust files
autocmd FileType rust nnoremap <buffer> <silent> <leader>r :below 10sp \| lcd %:h \| terminal cargo run<CR>

" diffview
lua require("diffview").setup()

" Use space as leader key
let mapleader = " "

" Jump between split panes
noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l

" Open terminal
nnoremap <silent> <leader>t :below 10sp \| terminal<CR>i

" Exit terminal mode using escape
tnoremap <Esc> <C-\><C-n>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
