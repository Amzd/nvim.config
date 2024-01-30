require("llm").setup({
    lsp = { bin_path = "/home/amzd/.cargo/bin/llm-ls"},
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
    request_body = { model = "codellama:7b-code" },
    query_params = {
        maxNewTokens = 60,
        temperature = 0.2,
        doSample = true,
        topP = 0.95,
    }
})
