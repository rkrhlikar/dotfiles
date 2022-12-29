local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'clangd',
    'rust_analyzer',
    'sumneko_lua',
})

lsp.set_preferences({
    sign_icons = {},
    set_lsp_keymaps = false
})

lsp.configure('clangd', {
    cmd = { 'clangd-12' }
})

lsp.configure('rust_analyzer', {
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
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, remap = false }
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    local telescope_builtin = require 'telescope.builtin'
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)

    -- Format on write
    local format = function()
        vim.lsp.buf.formatting_sync(nil, 1000)
    end
    vim.api.nvim_create_autocmd('BufWritePre', { buffer = bufnr, callback = format })
end)

lsp.setup()
