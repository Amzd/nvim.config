local swift = vim.api.nvim_create_augroup("swift", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
   pattern = { "swift" },
   callback = function(event)
       vim.api.nvim_buf_set_option(event.buf, "commentstring", "// %s")

       vim.keymap.set("", "<leader>sc", ":!swift package clean; swift package resolve; swift build<cr>")
       vim.keymap.set("", "<leader>spr", ":!swift package resolve<cr>")
       vim.keymap.set("", "<leader>st", ":!swift test<cr>")
       vim.keymap.set("", "<leader>sb", ":!swift build<cr>")
       vim.keymap.set("", "<leader>sr", ":!swift run<cr>")
       vim.keymap.set("", "<C-b>", ":!swift build<cr>")
       vim.keymap.set("", "<C-r>", ":!swift run<cr>")
   end,
   group = swift,
})
