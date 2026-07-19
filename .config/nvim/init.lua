if vim.loader then
    vim.loader.enable()
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.options")
require("config.keymaps")

require("plugins")
require("config.colors")
