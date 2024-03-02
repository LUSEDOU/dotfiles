---
return {
    -- TMUX
    -- {
    --     'christoomey/vim-tmux-navigator',
    -- },

    --- Development
    -- Neodev
    {
        "folke/neodev.nvim",
        opts = {}
    },

    -- LSP

    -- Other themes
    {
        "rebelot/kanagawa.nvim",
        "Shatur/neovim-ayu",
        "Abstract-IDE/Abstract-cs",
    },

    -- Theme
    {
        "ajmwagar/vim-deus",
        dependencies = {
            {
                'xiyaowong/transparent.nvim',
                opts = true,
                config = function()
                    require('transparent').toggle(true)
                end
            },
        },
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd.colorscheme 'deus'
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },


    --- DB
    -- DadBod
    {
        'kristijanhusak/vim-dadbod-ui',
        enabled = false,
        dependencies = {
            {
                "tpope/vim-dadbod",
                -- lazy = true
            },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { 'sql', 'mysql', 'plsql' },
                -- lazy = true,
            },
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end
    },

    -- Comment
    {
        'numToStr/Comment.nvim',
        opts = {}
    },


    {
        'tpope/vim-sleuth'
    },

    -- Which Key
    {
        'folke/which-key.nvim', opts = {},
    },

}
