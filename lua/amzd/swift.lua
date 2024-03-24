vim.api.nvim_create_autocmd("FileType", {
    pattern = { "swift" },
    callback = function(event)
        vim.api.nvim_buf_set_option(event.buf, "commentstring", "// %s")
        if vim.fs.find("Package.swift", { path = vim.loop.cwd() }) and not vim.fs.find("Makefile", { path = vim.loop.cwd() }) then
            vim.api.nvim_buf_set_option(event.buf, "makeprg", "swift")
        end

        vim.keymap.set("", "<leader>sc", ":!swift package clean; rm -rf .build; swift package resolve; swift build<cr>")
        vim.keymap.set("", "<leader>spr", ":!swift package resolve<cr>")
        vim.keymap.set("", "<leader>st", "<cmd>make test<cr>")
        vim.keymap.set("", "<leader>sb", "<cmd>make build<cr>")
        vim.keymap.set("", "<leader>sr", "<cmd>make run<cr>")
    end,
    group = vim.api.nvim_create_augroup("swift", { clear = true }),
})

-- open localhost on save in Publish projects
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*/Content/*.md" },
    callback = function(event)
        if vim.fs.find("Package.swift", { path = vim.loop.cwd() })
            and vim.fs.find(".publish", { path = vim.loop.cwd() }) then

            -- get the name of the only folder inside the Sources directory
            local folder = vim.fn.glob("Sources/*", 0, 1)[1]:sub(9)
            vim.fn.jobstart("swift run " .. folder .. " OPEN_LOCALHOST USE_DEBUG_FOLDER SKIP_MARKDOWN_DOWNLOAD")
        end
    end,
    group = vim.api.nvim_create_augroup("swift-publish", { clear = true }),
})
