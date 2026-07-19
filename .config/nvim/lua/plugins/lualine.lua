require("lualine").setup({
    options = {
        theme = "auto",
        globalstatus = true,

        component_separators = {
            left = "󰿟",
            right = "󰿟"
        },

        section_separators = {
            left = "",
            right = ""
        },
    },

    sections = {
        lualine_x = {},

        lualine_y = { "filetype" },
    },

    inactive_sections = {
        lualine_x = { "filetype" },
    },
})
