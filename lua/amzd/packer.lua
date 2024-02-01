-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use("nvim-treesitter/playground")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    -- use("tpope/vim-fugitive") -- git
    use("nvim-treesitter/nvim-treesitter-context");
    use("eandrju/cellular-automaton.nvim") -- <leader>fml

    -- amzd
    use("nvim-lualine/lualine.nvim")
    use("arzg/vim-colors-xcode")      -- colorscheme
    use { "mg979/vim-visual-multi", setup = function()
        vim.g.VM_default_mappings = 0 -- disables shift arrows starting visual multi mode
        vim.g.VM_maps = {
            ["Add Cursor Down"] = "<C-Down>",
            ["Add Cursor Up"] = "<C-Up>",
        }
    end }
    use("David-Kunz/gen.nvim") -- AI
    use("numToStr/Comment.nvim")

    -- use("jerrymarino/SwiftPlayground.vim") -- broken
    -- Mason helps updating installed LSP servers through :Mason command.
    -- This isn't needed for SourceKit-LSP because it is bundled with swift
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }

    -- This does not currently work with ollama
    use { "gnanakeethan/llm.nvim" }
    -- use { "tzachar/cmp-ai" , requires = { "nvim-lua/plenary.nvim" }}

    -- LSP Support
    use { 'neovim/nvim-lspconfig' }

    -- Autocompletion
    use { 'hrsh7th/nvim-cmp' }
    -- Autocompletion sources (added in cmp.setup)
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lua' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }

    -- Snippets
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }

    use {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    }
    use { "Yoolayn/nvim-intro" }
    -- displays keybindings for commands
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end
    }
    -- autopairs
    use("windwp/nvim-autopairs")
    use("ryanoasis/vim-devicons")
    -- filetree
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    }
    -- dev plugin
    use {
        "~/dev/plugins/playground.nvim",
        config = function()
            require("playground").setup({
                fix_lsp = true -- optional argument to turn off the lsp fix
            })
        end
    }
end)
