return {
    "gnanakeethan/llm.nvim",
    config = function ()
        require("llm").setup({
            enable_suggestions_on_files = {
                -- disable suggestions in all Telescope windows by enabling only in:
                "*.*", -- either has file extension
                "*/zshrc.d/*", -- or in zshrc.d folder
            },
            lsp = {
                -- cargo install --rev 16606e5371a1b0582543f03fd8a2666f7bf2580a --git https://github.com/huggingface/llm-ls llm-ls
                bin_path = vim.fn.expand("~/.cargo/bin/llm-ls"),
            },
            tokens_to_clear = { "<EOT>" },
            fim = {
                enabled = true,
                prefix = "<PRE> ",
                middle = " <MID>",
                suffix = " <SUF>",
            },
            model = "http://localhost:11434/api/generate",
            context_window = 4096,
            tokenizer = {
                repository = "codellama/CodeLlama-7b-hf",
            },
            adaptor = "ollama",
            request_body = {
                model = "codellama:7b-code",
            },
            query_params = {
                maxNewTokens = 60,
                temperature = 0.2,
                doSample = true,
                topP = 0.95,
            },
            accept_keymap = "<S-Down>",
            dismiss_keymap = "<S-Up>",
        })
    end
}
