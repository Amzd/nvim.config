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

local ns = vim.api.nvim_create_namespace("amzd/playground.nvim")
local replOutputFileName = ".amzd.playground.nvim.temp" -- file is safe to delete manually
local debug = true

local function debugprint(...)
    if debug then print(...) end
end
vim.lsp.buf.add_workspace_folder()
local repls = {
    ["swift"] = {
        command = "if [ -f Package.swift ]; then swift run --repl; else swift repl; fi",
        filePattern = "*%.playground/*.swift",
        exit = { ":quit" }, -- string used to quit the repl
        readyForLinePattern = "^%s+%d+[%.>]%s-$",
        gsubLines = {
            ["^#!/usr/bin/env swift.*"] = "", -- remove the bin/env line because it doesn't work in swift repl
            ["^%s*"] = "", -- remove indentation because the repl already indents
        },
        commentstring = "// %s", -- only needed if nvim option commentstring is not set for this language
    },
    ["python"] = {
        command = "python",
        filePattern = "*.py",
        exit = { "", "", "exit()" }, -- python needs a few extra returns to get out of possible nested block
        readyForLinePattern = "^[%.>][%.>][%.>]%s-$", -- >>> or ...
        gsubLines = {
            ["^#!/usr/bin/env py.*"] = "", -- remove the bin/env line because it doesn't work in repl
        },
    },
}

-- repls = {} -- disabled
for key, repl in pairs(repls) do
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("swift-playground-" .. key, { clear = true }),
        pattern = repl.filePattern,
        callback = function (event)
            local playgroundBuf = event.buf
            local playgroundLines = vim.api.nvim_buf_get_lines(playgroundBuf, 0, -1, true)

            -- insert a line at the start which we will use to detect start of code block when finished
            local commentstring = repl.commentstring or vim.api.nvim_buf_get_option(playgroundBuf, "commentstring")
            local startIndicator = commentstring:gsub("%%s", "amzd/playground.nvim start indicator")
            table.insert(playgroundLines, 1, startIndicator)
            for _, line in ipairs(repl.exit) do
                table.insert(playgroundLines, line)
            end

            vim.diagnostic.hide(ns, playgroundBuf)

            vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
                relative = "editor",
                width = 50, -- don't change without changing skipLines
                height = 1000,
                anchor = "NW",
                row = 0,
                col = 0,
            })
            local replBuf = vim.api.nvim_get_current_buf()
            local replWin = vim.api.nvim_get_current_win()

            assert(not repl.command:match("\""), "Do not use \" in commands")
            local longestPlaygroundLine = 0
            for _, line in ipairs(playgroundLines) do
                longestPlaygroundLine = math.max(#line, longestPlaygroundLine)
            end

            -- Using tmux because the terminal buffers in (n)vim cannot turn off their
            -- line wrap and so it is impossible to distinguish between lines when reading
            -- the terminal buffer. So instead the session is managed by tmux and I write
            -- the buffer to file with `capture-pane` and option -J which joins any wrapped lines.
            -- Using tmux resize-window to make sure the input lines don't get wrapped as -J does
            -- not unwrap those lines. Using tmux set status off; because otherwise the decoding
            -- code mistakes the tmux status bar for a line.
            local replChannel = vim.fn.termopen("tmux new \""
                                                .. "tmux resize-window -x 1" .. tostring(longestPlaygroundLine + 10) .. ";"
                                                .. "tmux set status off;"
                                                .. repl.command .. ";"
                                                .. "tmux capture-pane -pJ -S - > " .. replOutputFileName
                                                .. "\""
                                                , {
                on_exit = function ()
                    local replLines = vim.fn.readfile(replOutputFileName)
                    if not debug then os.remove(replOutputFileName) end
                    debugprint(replOutputFileName)
                    debugprint("replLines:", table.concat(replLines, "\n"))
                    debugprint("startIndicator", startIndicator)

                    while not replLines[1]:match(startIndicator) do
                        table.remove(replLines, 1)
                    end

                    debugprint("first line after startIndicator", replLines[1])

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
                            debugprint("replLine did not match playground line: (replline, playgroundline)")
                            debugprint(replLines[1])
                            debugprint(pgLine)

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
                end
            })

            vim.api.nvim_win_hide(replWin)

            local nextLineNr = 1 -- the next line from playground to input into repl
            vim.api.nvim_buf_attach(replBuf, false, {
                on_lines = function(_, _, _, _, _lastChangeNr)
                    debugprint("attach", _lastChangeNr)
                    local lastChangeNr = _lastChangeNr
                    local skipLines = { "", "────────────────────────────────────────────" }
                    while vim.tbl_contains(skipLines, vim.api.nvim_buf_get_lines(replBuf, lastChangeNr-1, lastChangeNr, true)[1]) do
                        -- skip empty lines at the end of buffer that get appended due to ANSI codes
                        -- and lines containing only ─ because those are created by tmux when using too wide window
                        lastChangeNr = lastChangeNr - 1
                    end

                    local lastChangesUpUntilEnd = vim.api.nvim_buf_get_lines(replBuf, lastChangeNr-1, lastChangeNr, true)

                    -- wait until last line was changed to repl.readyForLinePattern
                    if #lastChangesUpUntilEnd == 1 and lastChangesUpUntilEnd[1]:match(repl.readyForLinePattern) then
                        if #playgroundLines >= nextLineNr then
                            -- send next line to repl
                            local nextLine = playgroundLines[nextLineNr]
                            for pattern, substitute in pairs(repl.gsubLines) do
                                nextLine = nextLine:gsub(pattern, substitute)
                            end
                            debugprint("sending to repl:", nextLine)
                            vim.fn.chansend(replChannel, nextLine .. "\n")
                            nextLineNr = nextLineNr + 1
                        end
                    elseif #lastChangesUpUntilEnd then
                        debugprint("did not match readyForLinePattern:", lastChangesUpUntilEnd[1], "\\n", lastChangeNr)
                        debugprint("where is match in:", table.concat(vim.api.nvim_buf_get_lines(replBuf, 0, -1, true), "\n"))
                    end
                end
            })
        end
    })
end
