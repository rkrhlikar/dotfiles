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

        local telescope = require("telescope.builtin")
        map("n", "gd", telescope.lsp_definitions, opts)
        map("n", "gr", telescope.lsp_references, opts)

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

-- Telescope
local telescope = require("telescope.builtin")

vim.keymap.set(
    "n",
    "<leader>ff",
    telescope.find_files,
    {
        desc = "Find files",
    }
)

vim.keymap.set(
    "n",
    "<leader>fg",
    telescope.live_grep,
    {
        desc = "Live grep",
    }
)

vim.keymap.set(
    "n",
    "<leader>fb",
    telescope.buffers,
    {
        desc = "Find buffers",
    }
)

vim.keymap.set(
    "n",
    "<leader>fh",
    telescope.help_tags,
    {
        desc = "Help tags",
    }
)
