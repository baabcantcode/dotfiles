return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                vim.keymap.set('n', 'K', function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set('n', 'gd', function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set('n', 'gD', function()
                    vim.lsp.buf.declaration()
                end, opts)
                vim.keymap.set('n', 'gi', function()
                    vim.lsp.buf.implementation()
                end, opts)
                vim.keymap.set('n', 'go', function()
                    vim.lsp.buf.type_definition()
                end, opts)
                vim.keymap.set('n', 'gr', function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set('n', 'gs', function()
                    vim.lsp.buf.signature_help()
                end, opts)
                vim.keymap.set('n', '<F2>', function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set('n', '<F4>', function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set({ 'n', 'x' }, '<leader>bf', function()
                    vim.lsp.buf.format({ async = false })
                end, opts)
                vim.keymap.set("n", "<leader>rn", function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set("n", "<leader>rw", function()
                    vim.lsp.buf.workspace_symbol()
                end, opts)
                vim.keymap.set("n", "<leader>rd", function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, opts)
                vim.keymap.set("n", "<leader>ra", function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set("n", "<leader>rr", function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, opts)
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })

            require('mason-lspconfig').setup({
                ensure_installed = { "tsserver", "rust_analyzer", "gopls", "templ", "bashls", "tailwindcss", "lua_ls", "zls", "yamlls", "sqlls", "pyright", "intelephense" },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                }
            })
        end
    },
}
