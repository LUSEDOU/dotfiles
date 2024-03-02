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
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    },

    -- Flutter Tools
    {
        'akinsho/flutter-tools.nvim',
        -- lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = true,
    },

    -- Trouble
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- VimTex
    {
        'lervag/vimtex',
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
        config = function()
            vim.cmd.colorscheme 'deus'
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            { "nvim-treesitter/nvim-treesitter-context" },
        },
        build = ':TSUpdate',
    },


    -- NeoTest
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            'sidlatau/neotest-dart'
        },
    },

    --- DB
    -- DadBod
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            {
                "tpope/vim-dadbod", lazy = true
            },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { 'sql', 'mysql', 'plsql' },
                lazy = true,
            },
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end
    },

    -- Zen Mode
    { 'folke/zen-mode.nvim' },

    -- Harpoon

    -- UndoTree
    { 'mbbill/undotree' },

    -- Vim Fugitive
    { 'tpope/vim-fugitive' },

    -- Copilot
    {
        'zbirenbaum/copilot.lua',
        build = ":Copilot auth",
    },

    -- Comment
    {
        'numToStr/Comment.nvim',
        opts = {}
    },


    -- Autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    {
        'tpope/vim-sleuth'
    },

    -- Which Key
    {
        'folke/which-key.nvim', opts = {},
    },

    -- Markdown Preview
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        -- dependencies = {
        --     'preservim/vim-markdown',
        -- }
    },
}
