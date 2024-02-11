return {
    "arzg/vim-colors-xcode",
    dependencies = { "nvim-lualine/lualine.nvim" },
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

        require("lualine").setup {
            options = {
                theme = "onedark"
            }
        }

        -- only one statusline instead of one per window
        vim.opt.laststatus = 3
    end
}
