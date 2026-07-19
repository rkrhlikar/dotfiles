require("catppuccin").setup({
    flavour = "mocha",

    transparent_background = false,

    custom_highlights = function(colors)
        return {
            Normal = {
                bg = "#000000",
            },
            NormalNC = {
                bg = "#000000",
            },
            SignColumn = {
                bg = "#000000",
            },
            EndOfBuffer = {
                bg = "#000000",
                fg = "#000000",
            },
            LineNr = {
                bg = "#000000",
            },
            CursorLineNr = {
                bg = "#000000",
            },
            CursorLine = {
                bg = "#11111b",
            },
        }
    end,
})

vim.cmd.colorscheme("catppuccin")
