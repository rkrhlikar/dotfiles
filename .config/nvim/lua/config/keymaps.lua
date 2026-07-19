local map = vim.keymap.set

-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>l", "<C-w>l")

-- Better split creation
map("n", "<leader>sv", "<C-w>v")
map("n", "<leader>sh", "<C-w>s")

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Open mini.files
map("n", "<leader>e", function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open file explorer" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }

        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)

        map("n", "<leader>i", vim.lsp.buf.hover, opts)
        map("n", "<leader>d", vim.diagnostic.open_float, opts)
        map("n", "]d", vim.diagnostic.goto_next, opts)
        map("n", "[d", vim.diagnostic.goto_prev, opts)

        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        map(
            "n",
            "<leader>f",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                })
            end,
            {
                desc = "Format buffer",
            }
        )
    end,
})
