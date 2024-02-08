require("amzd.set")
require("amzd.remap")
require("amzd.swift")
require("amzd.plugins")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- helper to reload a lua module
function R(name)
    require("plenary.reload").reload_module(name)
end

-- highlights the yanked text for 40ms
autocmd('TextYankPost', {
    group = augroup('HighlightYank', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- remove white space in file before save
autocmd({"BufWritePre"}, {
    group = augroup('amzd', {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25
