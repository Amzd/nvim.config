local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-O>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-F>', function()
	builtin.grep_string({ search = "" })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

