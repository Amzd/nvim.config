vim.g.mapleader = " "

-- editor mappings -
vim.keymap.set({"i", "n"}, "<C-a>", "<Esc>ggVG", { desc =  "Select all" })
vim.keymap.set("v", "<C-c>", "y<Esc>i",          { desc =  "Copy" })
vim.keymap.set("v", "<C-x>", "d<Esc>i",          { desc =  "Cut" })
vim.keymap.set("n", "<C-v>", "pv=",              { desc =  "Paste n" })
vim.keymap.set("i", "<C-v>", "<Esc>pv=a",        { desc =  "Paste i" })
vim.keymap.set("v", "<C-v>", "\"_d<Esc>p=",      { desc =  "Paste v" })
vim.keymap.set("i", "<C-z>", "<Esc>ui",          { desc =  "Undo" })
vim.keymap.set("", "<C-z>", "<Esc>u",            { desc =  "Undo" })
vim.keymap.set("i", "<C-s>", "<Esc><Esc>:w<CR>", { desc =  "Save" })
vim.keymap.set("n", "<C-s>", "<Esc>:w<Enter>",   { desc =  "Save" })
vim.keymap.set("v", "<Backspace>", "\"_s",       { desc =  "Start editing when selecting and using Backspace" })
vim.keymap.set("n", "<Backspace>", "\"_s",       { desc =  "Start editing when selecting and using Backspace" })
vim.keymap.set("i", "<C-H>", "<Esc>vbd<Esc>i",   { desc =  "Delete until beginning of word (d^ would be to next whitespace)" }) -- C-H == C-Backspace (https://old.reddit.com/r/neovim/comments/okbag3/how_can_i_remap_ctrl_backspace_to_delete_a_word/h5999bi/)
vim.keymap.set("n", "<C-q>", "<C-w>q",           { desc =  "Close window" })

-- correct selection behaviour when in insert mode
-- - goes into (insert) Visual mode
-- - selects from in between characters bc thats where the cursor line is
vim.keymap.set("i", "<S-Left>", "<C-o>h<C-o>v")
vim.keymap.set("i", "<S-Right>", "<C-o>v")

-- wrap selection in '"<[{(
vim.keymap.set("x", "'", "s''<Esc>hpa", { desc = "Wrap selection in ''" })
vim.keymap.set("x", '"', 's""<Esc>hpa', { desc = "Wrap selection in \"\"" })
vim.keymap.set("x", "<", "s<><Esc>hpa", { desc = "Wrap selection in <>" })
vim.keymap.set("x", "[", "s[]<Esc>hpa", { desc = "Wrap selection in []" })
vim.keymap.set("x", "{", "s{}<Esc>hpa", { desc = "Wrap selection in {}" })
vim.keymap.set("x", "(", "s()<Esc>hpa", { desc = "Wrap selection in ()" })

-- place completing <[{( (Now done by autopairs)
-- vim.keymap.set("i", "<", "<><Esc>i", { desc = "Complete the character pair" })
-- vim.keymap.set("i", "[", "[]<Esc>i", { desc = "Complete the character pair" })
-- vim.keymap.set("i", "{", "{}<Esc>i", { desc = "Complete the character pair" })
-- vim.keymap.set("i", "(", "()<Esc>i", { desc = "Complete the character pair" })

-- movement
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_next()<CR>zz", { desc = "Go to prev error" })
vim.keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_prev()<CR>zz", { desc = "Go to next error" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected line(s) up" })

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>") -- de-stress
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
    if vim.fn.expand("%") == "lua/amzd/packer.lua" then
        vim.cmd("PackerSync")
    end
end)

-- search
vim.keymap.set("n", "n", "nzzzv", { desc = "Center on next search occurrence" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center on prev search occurrence" })

-- de-yank
vim.keymap.set("x", "p", "\"_dP", { desc = "Replace selected text without yanking" })
vim.keymap.set("x", "yp", "p",    { desc = "Replace selected text and yank" })
local deletekeys = {
    d = "Delete Text",
    D = "Delete Rest of Line",
    c = "Change Text",
    C = "Change Rest of Line",
    x = "Delete Next Character",
    X = "Delete Previous Character",
    s = "Substitute Text",
    S = "Substitute Rest of Line",
}
for key, desc in pairs(deletekeys) do
    vim.keymap.set({"n", "x"}, key, "\"_" .. key, { desc = desc .. " without yanking" })
    vim.keymap.set({"n", "x"}, "y" .. key, key,   { desc = desc .. " and yank" })
end

-- theprimeagen

-- vim.keymap.set("n", "J", "mzJ`z")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank into clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
