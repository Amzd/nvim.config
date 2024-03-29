-- vim.opt.guicursor = "" -- disables the cursor and makes it just an underscore

vim.opt.spell = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "0"

vim.opt.keymodel = "startsel,stopsel" -- allows selecting with Shift+Arrows

vim.opt.fillchars:append({eob = " "}) -- removes tildes after last line (end of buffer)

vim.filetype.add {
    pattern = {
        [".*/.zshrc.d/functions/.*"] = "sh"
    }
}
