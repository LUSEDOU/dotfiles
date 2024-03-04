return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        {
            'sidlatau/neotest-dart',
        },
    },
    keys = {
        { "<leader>tt", function() require('neotest').run.run() end, },
        { "<leader>tf", function() require('neotest').run.run(vim.fn.expand('%')) end, },
        { "<leader>ts", function() require('neotest').run.stop() end, },
    },
    config = function()
        require('neotest').setup {
            adapters = {
                require('neotest-dart') {
                    -- command = 'fvm flutter',
                    use_fvm = true,
                },
            }
        }
    end,
}
