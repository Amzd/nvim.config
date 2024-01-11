function ColorMyPencils(color)
    color = color or "xcodedarkhc"
    vim.cmd.colorscheme(color)

    -- remove backround
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

    -- fix matching parens being blue in xcodedarkhc
    vim.api.nvim_set_hl(0, "MatchParen", { bg = "#43454b" })

    -- Visual Multi cursor colors
    vim.g.VM_Mono_hl = "CursorLine"
    vim.g.VM_Extend_hl = "CursorLine"
    vim.g.VM_Cursor_hl = "Cursor"
    vim.g.VM_Insert_hl = "CursorLine"
end

ColorMyPencils()
