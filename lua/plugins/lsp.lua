return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Mason helps updating installed LSP servers through :Mason command.
        -- This isn't needed for SourceKit-LSP because it is bundled with swift
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        -- Autocompletion sources (added in cmp.setup)
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function ()
        require('mason').setup()
        require('mason-lspconfig').setup()

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local opts = { capabilities = lsp_capabilities }

        if os.getenv("iOS") == "1" then
            local home = vim.fn.expand("~")
            require("lspconfig").sourcekit.setup {
                capabilities = lsp_capabilities,
                cmd = {
                    "sourcekit-lsp",
                    "-Xcc", "-isysroot", "-Xcc", home .. "/.swiftpm/swift-sdks/darwin.artifactbundle/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk",
                    "-Xcc", "-target", "-Xcc", "arm64-apple-ios15",
                    "-Xswiftc", "-sdk", "-Xswiftc", home .. "/.swiftpm/swift-sdks/darwin.artifactbundle/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk",
                    "-Xswiftc", "-target", "-Xswiftc", "arm64-apple-ios15",
                    "-Xswiftc", "-resource-dir", "-Xswiftc", home .. "/.swiftpm/swift-sdks/darwin.artifactbundle/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift",
                    -- "-Xswiftc", "-I", "-Xswiftc", ".build/debug",
                    -- "-Xswiftc", "-L", "-Xswiftc", ".build/debug",
                }
            }
        else
            require("lspconfig").sourcekit.setup(opts)
        end
        require("lspconfig").pylsp.setup(opts)
        require("lspconfig").rust_analyzer.setup(opts)
        require("lspconfig").bashls.setup(opts)
        require("lspconfig").lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })
        require("lspconfig").r_language_server.setup({
            capabilities = lsp_capabilities,
            settings = {
                diagnostics = {
                    disable = { 'assignment_linter' },
                },
            },
        })


        local cmp = require('cmp')
        cmp.setup({
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
                -- { name = "cmp_ai" },
            },
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-Space>'] = cmp.mapping.complete(),
                -- ['<Tab>'] = cmp_action.luasnip_jump_forward(),
                -- ['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-x>'] = cmp.mapping(
                    cmp.mapping.complete({
                        config = {
                            sources = cmp.config.sources({
                                { name = 'cmp_ai' },
                            }),
                        },
                    }),
                    { 'i' }
                ),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf, remap = false }

                vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts) -- go to definition
                vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)       -- show info at current pos
                -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                vim.keymap.set("n", "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                vim.keymap.set("n", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
            end
        })

        local ls = require("luasnip")
        vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

        vim.diagnostic.config({
            virtual_text = true
        })
    end
}
