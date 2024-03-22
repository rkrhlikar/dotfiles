local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, remap = false }
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('v', '<leader>fs', vim.lsp.buf.format, opts)

    local telescope_builtin = require 'telescope.builtin'
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)

    -- Format on write
    lsp_zero.buffer_autoformat();
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'lua_ls',
        'marksman',
        'emmet_language_server',
        'tsserver'
    },
    handlers = {
        lsp_zero.default_setup,
    }
})

require('lspconfig').rust_analyzer.setup({
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

local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})
