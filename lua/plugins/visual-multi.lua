return {
    "mg979/vim-visual-multi",
    config = function()
        vim.g.VM_default_mappings = 0 -- disables shift arrows starting visual multi mode
        vim.g.VM_maps = {
            ["Add Cursor Down"] = "<C-Down>",
            ["Add Cursor Up"] = "<C-Up>",
        }
    end
}
