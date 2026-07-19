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
})

require("plugins.mini-files")
require("plugins.treesitter")
require("plugins.lualine")
