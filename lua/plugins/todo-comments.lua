return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
    },
    config = function ()
        require("todo-comments").setup()
    end
}
