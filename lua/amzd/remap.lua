vim.g.mapleader = " "

-- editor mappings -
vim.keymap.set("v", "<C-c>", "y<Esc>i") -- copy
vim.keymap.set("v", "<C-x>", "d<Esc>i") -- cut
vim.keymap.set("n", "<C-v>", "vPv=") -- paste n
vim.keymap.set("i", "<C-v>", "<Esc>Pv=i") -- paste i
vim.keymap.set("v", "<C-v>", "\"_d<Esc>P=") -- paste v
vim.keymap.set("i", "<C-z>", "<Esc>ui") -- undo
vim.keymap.set("", "<C-z>", "<Esc>u") -- undo
vim.keymap.set("i", "<C-s>", "<Esc>:w<Enter>") -- save
vim.keymap.set("n", "<C-s>", "<Esc>:w<Enter>") -- save
vim.keymap.set("v", "<Backspace>", "s") -- start editing when selecting and using Backspace
vim.keymap.set("n", "<Backspace>", "s") -- start editing when selecting and using Backspace
vim.keymap.set("i", "<C-H>", "<Esc>vbd<Esc>i") -- delete until beginning of word (d^ would be to next whitespace) -- C-H == C-Backspace (https://old.reddit.com/r/neovim/comments/okbag3/how_can_i_remap_ctrl_backspace_to_delete_a_word/h5999bi/)

-- correct selection behaviour when in insert mode
-- - goes into (insert) Visual mode
-- - selects from in between characters bc thats where the cursor line is
vim.keymap.set("i", "<S-Left>", "<C-o>h<C-o>v")
vim.keymap.set("i", "<S-Right>", "<C-o>v")

-- wrap selection in '"<[{(
vim.keymap.set("v", "'", "s''<Esc>hpa")
vim.keymap.set("v", '"', 's""<Esc>hpa')
vim.keymap.set("v", "<", "s<><Esc>hpa")
vim.keymap.set("v", "[", "s[]<Esc>hpa")
vim.keymap.set("v", "{", "s{}<Esc>hpa")
vim.keymap.set("v", "(", "s()<Esc>hpa")

-- movement
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_next()<CR>zz") -- go to prev error
vim.keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_prev()<CR>zz") -- go to next error
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected line(s) down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected line(s) up

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>") -- de-stress
vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>") --


-- theprimeagen

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

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/amzd/packer.lua<CR>")

