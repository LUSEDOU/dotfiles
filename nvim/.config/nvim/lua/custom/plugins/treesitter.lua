return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        keys = {
            {
                '[c',
                function()
                    require('treesitter-context').go_to_context(vim.v.count1())
                end,
                desc = 'Previous context'
            },
            { ']c', function() require('treesitter-context').next() end, desc = 'Next context' },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ':TSUpdate',
        event = 'BufReadPre',
        opts = {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "bash", 'dart', },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    }
}
