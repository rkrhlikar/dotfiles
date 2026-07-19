local treesitter = require("nvim-treesitter")

treesitter.setup({})

treesitter.install({
    "lua",
    "vim",
    "vimdoc",

    "rust",

    "javascript",
    "typescript",
    "tsx",

    "json",

    "markdown",
    "markdown_inline",
})
