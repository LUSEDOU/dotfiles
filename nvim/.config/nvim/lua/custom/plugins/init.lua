return {
    -- Themes
    {
        "rebelot/kanagawa.nvim",
        -- "Shatur/neovim-ayu",
        -- "Abstract-IDE/Abstract-cs",
        -- "rktjmp/lush.nvim",
        -- "tckmn/hotdog.vim",
        -- "dundargoc/fakedonalds.nvim",
        -- "craftzdog/solarized-osaka.nvim",
        { "rose-pine/neovim", name = "rose-pine" },
        "Mofiqul/dracula.nvim",
        -- "eldritch-theme/eldritch.nvim",
        -- "jesseleite/nvim-noirbuddy",
        -- "vim-scripts/MountainDew.vim",
        -- "miikanissi/modus-themes.nvim",
        "rebelot/kanagawa.nvim",
        -- "gremble0/yellowbeans.nvim",
        -- "rockyzhang24/arctic.nvim",
        -- "folke/tokyonight.nvim",
        -- "Shatur/neovim-ayu",
        "RRethy/base16-nvim",
        -- "xero/miasma.nvim",
        -- "cocopon/iceberg.vim",
        -- "kepano/flexoki-neovim",
        -- "ntk148v/komau.vim",
        -- { "catppuccin/nvim",  name = "catppuccin" },
        -- "uloco/bluloco.nvim",
        -- "LuRsT/austere.vim",
        -- "ricardoraposo/gruvbox-minor.nvim",
        -- "NTBBloodbath/sweetie.nvim",
    },

    {
        'xiyaowong/transparent.nvim',
        priority = 1001,
        lazy = false,
        opts = true,
        config = function()
            require 'transparent'.toggle(true)
        end
    },

    -- Theme
    {
        "ajmwagar/vim-deus",
        priority = 1000,
        lazy = false,
        config = function()
            require 'lusedou.color'.load_theme('deus')
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
