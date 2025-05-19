return {
    "arzg/vim-colors-xcode",
    dependencies = {
        "nvim-lualine/lualine.nvim",
        "mawkler/modicator.nvim",
    },
    config = function ()
        vim.cmd.colorscheme("xcodedarkhc")

        -- remove background
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })

        -- fix matching parens being blue in xcodedarkhc
        vim.api.nvim_set_hl(0, "MatchParen", { bg = "#43454b" })

        -- Visual Multi cursor colors
        vim.g.VM_Mono_hl = "CursorLine"
        vim.g.VM_Extend_hl = "CursorLine"
        vim.g.VM_Cursor_hl = "Cursor"
        vim.g.VM_Insert_hl = "CursorLine"

        -- Colors taken from all around vim-colors-xcode
        local custom_theme = require("lualine.themes.onedark")
        custom_theme.normal.a.bg = "#cda1ff"
        custom_theme.insert.a.bg = "#4ec4e6"
        custom_theme.visual.a.bg = "#ff85b8"
        custom_theme.command.a.bg = "#ff8a7a"
        custom_theme.replace.a.bg = "#e5cfff"
        custom_theme.terminal.a.bg = "#e5cfff"
        custom_theme.normal.c.fg = "#FFF"

        require("lualine").setup {
            options = {
                component_separators = { left = "", right = ""},
                theme = custom_theme
            },
            sections = {
                lualine_b = { "branch" },
                lualine_c = {{
                    "buffers",
                    symbols = {
                        -- https://stackoverflow.com/questions/5182852/in-vim-what-is-the-alternate-file
                        -- maybe enable again if I start using alternate files more often
                        alternate_file = "",
                    }
                }},
                lualine_x = { "diff" },
            }
        }

        -- These are required for modicator to work
        vim.o.cursorline = true
        vim.o.number = true
        vim.o.termguicolors = true
        require('modicator').setup()

        -- only one statusline instead of one per window
        vim.opt.laststatus = 3
    end
}
