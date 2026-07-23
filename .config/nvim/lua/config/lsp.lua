local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "rust_analyzer",
    "emmet_language_server",
    "ts_ls",
    "marksman",
})
