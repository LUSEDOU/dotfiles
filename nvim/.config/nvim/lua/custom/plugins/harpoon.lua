return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    keys = function(_)
        local harpoon = require("harpoon")

        ---comment
        ---@param item integer
        local function select(item)
            harpoon:list():select(item)
        end

        return {
            {
                '<C-e>',
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Toggle quick menu"
            },
            {
                '<leader>a',
                function()
                    harpoon:list():append()
                end,
                desc = "Add current file"
            },
            { '<C-h>', function() select(1) end, desc = "Select h" },
            { '<C-t>', function() select(2) end, desc = "Select t" },
            { '<C-n>', function() select(3) end, desc = "Select n" },
            { '<C-s>', function() select(4) end, desc = "Select s" },
        }
    end,
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})
    end
}
