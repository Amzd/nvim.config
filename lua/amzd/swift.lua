local swift = vim.api.nvim_create_augroup("swift", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
   pattern = { "swift" },
   callback = function()
       -- local root_dir = vim.fs.dirname(vim.fs.find({
       --     "Package.swift",
       --     ".git",
       -- }, { upward = true })[1])
       -- local client = vim.lsp.start({
       --     name = "sourcekit-lsp",
       --     cmd = { "sourcekit-lsp" },
       --     root_dir = root_dir,
       -- })
       -- vim.lsp.buf_attach_client(0, client)

       vim.keymap.set("", "<leader>sc", ":!swift package clean; swift package resolve; swift build<cr>")
       vim.keymap.set("", "<leader>spr", ":!swift package resolve<cr>")
       vim.keymap.set("", "<leader>st", ":!swift test<cr>")
       vim.keymap.set("", "<leader>sb", ":!swift build<cr>")
       vim.keymap.set("", "<leader>sr", ":!swift run<cr>")
       vim.keymap.set("", "<C-b>", "<leader>sb")
       vim.keymap.set("", "<C-r>", "<leader>sr")
   end,
   group = swift,
})
