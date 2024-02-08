-- SETUP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- SPEC
require("lazy").setup {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ":TSUpdate",
    },
    "nvim-treesitter/playground",
    "theprimeagen/refactoring.nvim",
    "mbbill/undotree",
    -- use("tpope/vim-fugitive") -- git
    "nvim-treesitter/nvim-treesitter-context",
    "eandrju/cellular-automaton.nvim", -- <leader>fml

    -- amzd
    "nvim-lualine/lualine.nvim",
    "arzg/vim-colors-xcode",      -- colorscheme
    { "mg979/vim-visual-multi", setup = function()
        vim.g.VM_default_mappings = 0 -- disables shift arrows starting visual multi mode
        vim.g.VM_maps = {
            ["Add Cursor Down"] = "<C-Down>",
            ["Add Cursor Up"] = "<C-Up>",
        }
    end },
    "David-Kunz/gen.nvim", -- AI
    "numToStr/Comment.nvim",

    -- use("jerrymarino/SwiftPlayground.vim") -- broken
    -- Mason helps updating installed LSP servers through :Mason command.
    -- This isn't needed for SourceKit-LSP because it is bundled with swift
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- This does not currently work with ollama
    { "gnanakeethan/llm.nvim" },
    -- use { "tzachar/cmp-ai" , dependencies = { "nvim-lua/plenary.nvim" }}

    -- LSP Support
    { 'neovim/nvim-lspconfig' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    -- Autocompletion sources (added in cmp.setup)
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "Yoolayn/nvim-intro" },
    -- displays keybindings for commands
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end
    },
    -- autopairs
    "windwp/nvim-autopairs",
    "ryanoasis/vim-devicons",
    -- filetree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
    -- dev plugin
    {
        dir = "~/dev/plugins/playground.nvim",
        config = function()
            require("playground").setup({
                fix_lsp = true -- optional argument to turn off the lsp fix
            })
        end
    },
}
