-- SETUP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- SPEC
require("lazy").setup {
    spec = {
        { import = "plugins" },
        "nvim-treesitter/nvim-treesitter-context",
        "ryanoasis/vim-devicons",
    },
    change_detection = {
        -- don't notify me every time I save
        notify = vim.fn.getcwd() ~= vim.fn.expand("~") .. "./config/nvim",
    },
}
