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

local ns = vim.api.nvim_create_namespace("amzd/playground.nvim")

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("swift-playground", { clear = true }),
    pattern = "*.swift",
    callback = function (event)
        local repl = {
            command = { "swift", "repl" },
            exit = "//:quit", -- string used to quit the repl
            readyForLinePattern = "^%s+%d+[%.>]%s-$",
            gsubLines = {
                ["^#!/usr/bin/env swift.*"] = "", -- remove the bin/env line because it doesn't work in swift repl
                ["^%s*"] = "", -- remove indentation because the repl already indents
            },
            commentstring = "//", -- only needed if nvim option commentstring is not set for this language
        }

        local playgroundBuf = event.buf
        local playgroundLines = vim.api.nvim_buf_get_lines(playgroundBuf, 0, -1, true)

        -- insert a line at the start which we will use to detect start of code block when finished
        local commentstring = repl.commentstring or vim.api.nvim_buf_get_option(playgroundBuf, "commentstring")
        local startIndicator = commentstring .. " amzd/playground.nvmin start indicator"
        table.insert(playgroundLines, 1, startIndicator)
        table.insert(playgroundLines, repl.exit)

        -- vim.diagnostic.hide(ns, playgroundBuf)

        -- vim.cmd("new amzd.playground.nvim")

        vim.api.nvim_open_win(vim.api.nvim_create_buf(false, false), true, {
            relative = "editor",
            width = 10000,
            height = 8,
            anchor = "NW",
            row = 0,
            col = 0,
        })
        local replBuf = vim.api.nvim_get_current_buf()
        local replWin = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_option(replWin, "wrap", false)
        vim.api.nvim_buf_set_option(replBuf, "textwidth", 10000)

        local replChannel = vim.fn.termopen(repl.command, { on_exit = function ()
            local replLines = vim.api.nvim_buf_get_lines(replBuf, 0, -1, true)
            while not replLines[1]:match(startIndicator) do
                table.remove(replLines, 1)
            end

            local diagnostics = {}
            -- TODO: could I make this parser more robust by maybe using color codes?
            -- right now if someone would print the same as what I expect the repl to
            -- send then this breaks
            for i, _pgLine in ipairs(playgroundLines) do
                local pgLine = _pgLine
                for pattern, substitute in pairs(repl.gsubLines) do
                    pgLine = pgLine:gsub(pattern, substitute)
                end

                local pgLineLen = pgLine:len()
                local diagnostic = {
                    bufnr = playgroundBuf,
                    lnum = i-1-1-1, -- -1 to remove the start indicator and -1 to go to the previous line and -1 because line nr start at 0 where index starts at 1 (i think?)
                    col = 1,
                    source = "playground.nvim",
                    severity = vim.diagnostic.severity.INFO,
                }

                -- add the lines from the repl to the diagnostic of the previous line until we are at the line matching an input
                while #replLines > 0 and not (pgLineLen < replLines[1]:len() and replLines[1]:sub(1, -pgLineLen - 2):match(repl.readyForLinePattern)) do
                    if not diagnostic.message then
                        -- TODO: Parse errors and warnings into actual warnings?
                        -- could try to drop them and see if the lsp still shows warnings
                        diagnostic.message = table.remove(replLines, 1)
                        table.insert(diagnostics, diagnostic)
                    else
                        diagnostic.message = diagnostic.message .. "\n" .. table.remove(replLines, 1)
                    end
                end

                if #replLines > 0 then -- drop the line that matches an input
                    table.remove(replLines, 1)
                end
            end

            vim.diagnostic.set(ns, playgroundBuf, diagnostics)
            vim.api.nvim_buf_delete(replBuf, { force = true })
        end})

        vim.api.nvim_win_set_option(replWin, "wrap", false)
        vim.api.nvim_buf_set_option(replBuf, "textwidth", 10000)
        -- vim.api.nvim_buf_set_option(replBuf, "columns", 10000)
        -- vim.api.nvim_win_hide(replWin)

        local nextLineNr = 1 -- the next line from playground to input into repl
        vim.api.nvim_buf_attach(replBuf, false, {
            on_lines = function(_, _, _, _, lastChangeNr)
                while vim.api.nvim_buf_get_lines(replBuf, lastChangeNr-1, lastChangeNr, true)[1] == "" do
                    -- skip empty lines at the end of buffer that get appended due to ANSI codes
                    lastChangeNr = lastChangeNr - 1
                end

                local lastChangesUpUntilEnd = vim.api.nvim_buf_get_lines(replBuf, lastChangeNr-1, lastChangeNr, true)

                -- wait until last line was changed to repl.readyForLinePattern
                if #lastChangesUpUntilEnd == 1 and lastChangesUpUntilEnd[1]:match(repl.readyForLinePattern) then
                    if #playgroundLines >= nextLineNr then
                        -- send next line to repl
                        local nextLine = playgroundLines[nextLineNr]
                        nextLineNr = nextLineNr + 1
                        for pattern, substitute in pairs(repl.gsubLines) do
                            nextLine = nextLine:gsub(pattern, substitute)
                        end
                        vim.fn.chansend(replChannel, nextLine .. "\n")
                    end
                end
            end
        })
    end
})
