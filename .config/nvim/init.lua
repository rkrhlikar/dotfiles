if vim.loader then
    vim.loader.enable()
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.options")

require("plugins")
require("config.keymaps")
require("config.colors")
require("config.treesitter")
require("config.lsp")
