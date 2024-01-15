require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = "close", -- Esc once to close telescope
                ["<C-c>"] = false, -- C-c to exit insert mode to navigate with hjkl
            },
        },
    }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-O>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-F>', function()
	builtin.grep_string({ search = "" })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

-- remap the git_files for home directory to use dotfiles dir
local homedirmaps = vim.api.nvim_create_augroup('HomeDirMaps', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
    group = homedirmaps,
    pattern = '*',
    callback = function()
        if vim.fn.getcwd() == vim.fn.expand('~') then
            vim.keymap.set('n', '<C-p>', function() builtin.find_files {
                find_command = { "git", "--git-dir=" .. os.getenv("HOME") .. "/dev/dotfiles", "ls-tree", "-r", "HEAD", "--name-only" }
            } end)
        end
    end
})
