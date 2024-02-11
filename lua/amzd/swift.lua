vim.api.nvim_create_autocmd("FileType", {
    pattern = { "swift" },
    callback = function(event)
        vim.api.nvim_buf_set_option(event.buf, "commentstring", "// %s")
        if vim.fs.find("Package.swift", { path = vim.loop.cwd() }) then
            vim.api.nvim_buf_set_option(event.buf, "makeprg", "swift")
        end

        vim.keymap.set("", "<leader>sc", ":!swift package clean; rm -rf .build; swift package resolve; swift build<cr>")
        vim.keymap.set("", "<leader>spr", ":!swift package resolve<cr>")
        vim.keymap.set("", "<leader>st", "<cmd>make test<cr>")
        vim.keymap.set("", "<leader>sb", "<cmd>make build<cr>")
        vim.keymap.set("", "<leader>sr", "<cmd>make run<cr>")
        vim.keymap.set("", "<C-b>", "<cmd>make build<cr>")
        vim.keymap.set("", "<C-r>", "<cmd>make run<cr>")
    end,
    group = vim.api.nvim_create_augroup("swift", { clear = true }),
})

