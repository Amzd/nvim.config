-- To switch between local version and git version change the dev block in lazy.lua
return {
    {
        "amzd/make-me-less-frustrated.nvim",
        config = function()
            require("make-me-less-frustrated").setup()
        end
    },
    {
        "amzd/playground.nvim",
        config = function()
            require("playground").setup({
                fix_lsp = true -- optional argument to turn off the lsp fix
            })
        end
    },
    {
        "amzd/dontforgit.nvim",
        config = function()
            local git_command = "!git"
            local cwd = vim.fn.getcwd()
            if cwd == vim.fn.expand("~") or cwd == vim.fn.expand("~/.zshrc.d") then
                git_command = "!dot"
            end

            require("dontforgit").setup({
                notify_git_failed = false,
                git_command = git_command,
                prompt_prefix = git_command .. " ",
            })
        end
    },
}
