-- require('rose-pine').setup({
--     disable_background = true
-- })

function ColorMyPencils(color)
    color = color or "xcodedarkhc"
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, "MatchParen", {
        bg = "#43454b",
        -- underline = true,
    }) -- fixes matching parens being blue in default

    -- Visual Multi cursor colors
    vim.g.VM_Mono_hl = "CursorLine"
    vim.g.VM_Extend_hl = "CursorLine"
    vim.g.VM_Cursor_hl = "Cursor"
    vim.g.VM_Insert_hl = "CursorLine"
end

ColorMyPencils()
