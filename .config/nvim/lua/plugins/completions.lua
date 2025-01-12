return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        'hrsh7th/nvim-cmp',
        lazy = false,
        event = 'InsertEnter',
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
            },
        },
        config = function()
            local cmp = require('cmp')
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "path" },
                    { name = "buffer" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                },
                formatting = require('lsp-zero').cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-y>"] = cmp.mapping.complete(),
                }),
            })
        end
    },


}
