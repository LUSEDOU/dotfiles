return {
    -- TMUX
    -- {
    --     'christoomey/vim-tmux-navigator',
    -- },

    --- Development
    -- Neodev
    {
        "folke/neodev.nvim",
        opts = {},
        ft = 'lua',
    },


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


    -- Comment
    {
        'numToStr/Comment.nvim',
        opts = {},
        event = 'BufReadPre',
    },


    {
        'tpope/vim-sleuth',
        event = 'BufReadPre',
    },

    -- Which Key
    {
        'folke/which-key.nvim', opts = {},
    },

}
