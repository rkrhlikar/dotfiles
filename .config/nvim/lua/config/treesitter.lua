local languages = {
    "lua",
    "rust",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "markdown",
    "markdown_inline",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = languages,
    callback = function()
        vim.treesitter.start()
    end,
})
