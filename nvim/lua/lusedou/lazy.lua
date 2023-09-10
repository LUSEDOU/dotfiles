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

require("lazy").setup({
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
            { 'L3MON4D3/LuaSnip' },     -- Required
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

    -- VimTex
    {
        'lervag/vimtex',
    },

    -- Theme
    {
        -- "rebelot/kanagawa.nvim",
        "ajmwagar/vim-deus",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'deus'
        end,
    },

     -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
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

    -- Harpoon
    { 'ThePrimeagen/harpoon' },

    -- UndoTree
    { 'mbbill/undotree' },

    -- Vim Fugitive
    { 'tpope/vim-fugitive' },

    -- Copilot
    { 'github/copilot.vim' },

    -- Comment
    { 'numToStr/Comment.nvim', opts = {} },


    -- Autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    -- Which Key
    {
        'folke/which-key.nvim', opts = {},
    },

    -- Markdown Preview
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
    },

}, {})
