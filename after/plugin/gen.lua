require('gen').setup({
    model = "codellama:13b", -- The default model to use.
    display_mode = "split", -- The display mode. Can be "float" or "split".
    show_prompt = true, -- Shows the Prompt submitted to Ollama.
    show_model = false, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    init = function(options) pcall(io.popen, "$HOME/dev/ollama/ollama serve > /dev/null 2>&1 &") end,
    -- Function to initialize Ollama -- Using Ollama PR which supports AMD
    command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a lua function returning a command string, with options as the input parameter.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    debug = false -- Prints errors and the command which is run.
})

require('gen').prompts['Fix_Code'] = {
  prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  replace = true,
  extract = "```$filetype\n(.-)```",
}


require('gen').prompts['Fix_Err'] = {
    replace = true,
    extract = "```.-\n(.-)\n",
}

vim.keymap.set({'v', "n"}, '<leader>fix', function()
    local lsp = vim.lsp
    local cursor = vim.fn.getcurpos()
    local line_number = cursor[2] - 1
    local diagnostics = vim.diagnostic.get(0, { lnum = line_number })

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local filecontents = table.concat(lines, "\n")
    local line = tostring(line_number)
    local error = diagnostics[1].message

    require('gen').prompts['Fix_Err'].prompt = "This is my code: \n\n```$filetype\n" .. filecontents .. "```\n\n"
        .. "Tell me the replacement for line " .. line
        .. " that fixes the error \"" .. error
        .. "\" in format: ```$filetype\n...\n``` without any other description."
    vim.cmd("'<,'>Gen Fix_Err")
end)

vim.keymap.set("n", "<leader>ai", ":Gen Chat<CR>")
