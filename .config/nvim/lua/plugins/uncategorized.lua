return {
    {
        "folke/tokyonight.nvim",
        opts = { lazy = false }
    },
    { "folke/neodev.nvim", lazy = false },
    {
        "folke/which-key.nvim",
        opts = {},
        lazy = false,
        config = function(_, opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup(opts)
        end,
    },
    { -- Floating terminal
        "itmecho/neoterm.nvim",
        opts = {
            clear_on_run = true, -- run clear command before user specified commands
            mode = "horizontal", -- vertical/horizontal/fullscreen
            noinsert = false,    -- disable entering insert mode when opening the neoterm window
        },
        lazy = false,
        config = function(_, opts)
            require("neoterm").setup(opts)
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = {
                line = "<C-/>",
            },
            -- add any options here
        },
        opleader = {
            line = "gc",
            block = "gb",
        },
        lazy = false,
    },

}
