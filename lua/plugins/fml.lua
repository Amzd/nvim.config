return {
    "eandrju/cellular-automaton.nvim", -- <leader>fml
    config = function()
        vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>") -- de-stress
    end,
}
