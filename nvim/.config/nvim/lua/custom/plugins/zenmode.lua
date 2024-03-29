return {
    'folke/zen-mode.nvim',
    opts = {
        window = {
            width = 90,
            options = {
                number = true,
                relativenumber = true,
            }
        },
    },
    keys = {
        { '<leader>zz', function() require("zen-mode").toggle() end },
    },
    config = function()
        local nmap = require("lusedou.keymaps").nmap
        local zenmode = require("zen-mode")

        nmap {
            "<leader>zz",
            command = function()
                zenmode.toggle()
                -- vim.wo.wrap = false
                -- ColorMyPencils()
            end
        }
    end
}
