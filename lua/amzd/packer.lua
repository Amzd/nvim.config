-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- ThePrimeagen colorscheme
    -- use({
    --     'rose-pine/neovim',
    --     as = 'rose-pine',
    -- })

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
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");
    use("folke/zen-mode.nvim")
    --  use("github/copilot.vim")
    use("eandrju/cellular-automaton.nvim")

    -- amzd
    use("arzg/vim-colors-xcode") -- colorscheme
    use { "mg979/vim-visual-multi", setup = function ()
        vim.g.VM_default_mappings = 0 -- disables shift arrows starting visual multi mode
        vim.g.VM_maps = {
            ["Add Cursor Down"] = "<C-Down>",
            ["Add Cursor Up"] = "<C-Up>",
        }
    end}
    use("David-Kunz/gen.nvim")
    use("terrortylor/nvim-comment")
    -- use("jerrymarino/SwiftPlayground.vim") -- broken
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP server management from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            -- {'hrsh7th/cmp-buffer'},
            -- {'hrsh7th/cmp-path'},
            -- {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            -- {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    use("folke/neodev.nvim") -- autocomplete for vim.api stuff

end)
