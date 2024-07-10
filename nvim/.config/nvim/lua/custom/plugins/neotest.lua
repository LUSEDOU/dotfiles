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
        { "<leader>to", function() require('neotest').output_panel.toggle() end, },
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

        -- local autocmd = require 'lusedou.autocommands'.autocmd
        -- autocmd {
        --     event = 'BufWinEnter',
        --     pattern = '*test*',
        --     group = 'Lusedou_test'
        --     callback = function()
        --     end,
        -- }
    end,
}
