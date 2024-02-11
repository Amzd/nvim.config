return {
    {
        dir = "~/dev/plugins/playground.nvim",
        config = function()
            require("playground").setup({
                fix_lsp = true -- optional argument to turn off the lsp fix
            })
        end
    },
    {
        dir = "~/dev/plugins/dontforgit.nvim",
        config = function()
            local git_command = "git"
            if vim.fn.getcwd() == vim.fn.expand("~") then
                git_command = "dot"
            elseif vim.fn.getcwd() == vim.fn.expand("~/zshrc.d/") then
                git_command = "cd ~;dot"
            end

            require("dontforgit").setup({
                git_command = git_command,
                prompt_prefix = "!" .. git_command .. " ",
            })
        end
    },
}
