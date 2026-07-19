vim.pack.add({
    -- Dependency of Telescope and others
    {
        src = "https://github.com/nvim-lua/plenary.nvim",
    },
    {
        src = "https://github.com/catppuccin/nvim",
    },
    {
        src = "https://github.com/echasnovski/mini.nvim",
    },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
    },
    {
        src = "https://github.com/nvim-lualine/lualine.nvim",
    },

    -- LSP
    {
        src = "https://github.com/mason-org/mason.nvim",
    },
    {
        src = "https://github.com/neovim/nvim-lspconfig",
    },

    -- Autocomplete
    {
        src = "https://github.com/hrsh7th/nvim-cmp",
    },
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
    },
    {
        src = "https://github.com/hrsh7th/cmp-nvim-lsp",
    },
    {
        src = "https://github.com/hrsh7th/cmp-buffer",
    },
    {
        src = "https://github.com/hrsh7th/cmp-path",
    },
})

require("plugins.mini-files")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.mason")
require("plugins.cmp")
