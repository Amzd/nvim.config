-- editor mappings -
vim.keymap.set("v", "<C-c>", "y<Esc>i") -- copy
vim.keymap.set("v", "<C-x>", "d<Esc>i") -- cut
vim.keymap.set({"", "i"}, "<C-v>", "<Esc>pi") -- paste
vim.keymap.set("i", "<C-z>", "<Esc>ui") -- undo
vim.keymap.set("", "<C-z>", "<Esc>u") -- undo
vim.keymap.set("i", "<C-Z>", "<Esc>ui") -- TODO: redo? or open treesitter
vim.keymap.set("i", "<C-/>", "<Esc>I") -- comment (currently just sets insert on 1st line so you can manually type the comment character)
vim.keymap.set("i", "<C-s>", "<Esc>:w<Enter>") -- save
vim.keymap.set("", "<C-s>", "<Esc>:w<Enter>") -- save
vim.keymap.set("v", "<Backspace>", "d<Esc>i") -- start editing when selecting and using Backspace
vim.keymap.set("", "<Backspace>", "d1h<Esc>i") -- start editing when selecting and using Backspace
vim.keymap.set("i", "<C-H>", "<Esc>db<Esc>i") -- delete until beginning of word (d^ would be to next whitespace) -- C-H == C-Backspace (https://old.reddit.com/r/neovim/comments/okbag3/how_can_i_remap_ctrl_backspace_to_delete_a_word/h5999bi/)

-- todo: vim.lsp.diagnostic.goto_next()

-- theprimeagen

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/amzd/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

