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
vim.keymap.set('n', '<C-O>', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Search through help tags" })

vim.keymap.set('n', '<C-p>', function()
    if vim.fn.getcwd() == vim.fn.expand('~') then
        builtin.find_files({ find_command = { "git", "--git-dir=" .. os.getenv("HOME") .. "/dev/dotfiles", "ls-tree", "-r", "HEAD", "--name-only" } })
    else
        builtin.git_files()
    end
end, { desc = "Find git files" })

vim.keymap.set('n', '<C-f>', function()
	builtin.grep_string({ search = "" })
end, { desc = "Search content of files" })
