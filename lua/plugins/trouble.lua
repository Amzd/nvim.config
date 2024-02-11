return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({})
        local opts = require("trouble.config").options

        -- disable telescope provider to prevent the warning
        -- this is temporary and when you specifically open trouble with telescope it adds it again
        require("trouble.providers").providers["telescope"] = nil

        local current_mode
        vim.keymap.set("n", "<leader>xx", function ()
            local can_switch = true
            local all_providers = require("trouble.providers").providers

            for key, provider in pairs(all_providers) do
                provider(0, 0, function (results)
                    if can_switch and #(results or {}) > 0 and (current_mode ~= key or not require("trouble").is_open()) then
                        vim.cmd("Trouble " .. key)
                        -- require("trouble").open(key)
                        can_switch = false
                        current_mode = key
                        print("switch to", key)
                    end
                end, vim.tbl_deep_extend("force", opts, { mode = key }))
            end
        end)
    end
}
