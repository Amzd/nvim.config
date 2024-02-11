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
        local custom_onedark = require("lualine.themes.onedark")
        custom_onedark.normal.a.bg = "#cda1ff"
        custom_onedark.insert.a.bg = "#4ec4e6"
        custom_onedark.visual.a.bg = "#ff85b8"
        custom_onedark.command.a.bg = "#ff8a7a"
        custom_onedark.replace.a.bg = "#e5cfff"
        custom_onedark.terminal.a.bg = "#e5cfff"

        require("lualine").setup {
            options = {
                theme = custom_onedark
            },
            sections = {
                lualine_c = { "buffers" },
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
