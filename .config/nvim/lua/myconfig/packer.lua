local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "catppuccin/nvim", as = "catppuccin" }

    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate' }

    use { 'mbbill/undotree' }

    use { 'sindrets/diffview.nvim', requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-tree/nvim-web-devicons' } } }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use { 'nvim-lualine/lualine.nvim', config = function()
        local lualine = require 'lualine'
        lualine.setup({
            options = {
                theme = 'catppuccin',
                component_separators = { left = '󰿟', right = '󰿟' },
                section_separators = { left = '', right = '' }
            },
            sections = {
                lualine_x = {},
                lualine_y = { 'filetype' }
            },
            inactive_sections = {
                lualine_x = { 'filetype' }
            }
        })
    end
    }

    use { 'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown',
        config = function()
            require('render-markdown').setup({})
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
