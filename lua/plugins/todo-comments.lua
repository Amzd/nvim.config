return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
    },
    config = function ()
        require("todo-comments").setup()

        -- Add todo-comments to the list of providers
        -- This should be done by the plugin imo
        require("trouble.providers").providers["todo"] = require("trouble.providers.todo")
    end
}
