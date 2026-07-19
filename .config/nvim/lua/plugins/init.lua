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
})

require("plugins.mini-files")
