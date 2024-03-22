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

    use { 'tanvirtin/monokai.nvim',
        commit = '6fb4f7fee6ce7106fbde36149eeec91e55751a22', -- TODO: Remove after updating NVIM
        config = function()
            local monokai = require 'monokai'
            monokai.setup({ palette = monokai.pro })
        end
    }

    use { 'nvim-treesitter/nvim-treesitter',
        commit = 'a2d7e78b0714a0dc066416100b7398d3f0941c23', -- TODO: Remove after updating NVIM
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
        lualine.setup()
    end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
