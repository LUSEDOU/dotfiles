return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    keys = function()
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
            { '<C-h>', select(1), desc = "Select h" },
            { '<C-t>', select(2), desc = "Select t" },
            { '<C-n>', select(3), desc = "Select n" },
            { '<C-s>', select(4), desc = "Select s" },
        }
    end,
    config = function()
        local nmap = require("lusedou.keymaps").nmap
        local harpoon = require("harpoon")

        harpoon:setup({})

        nmap {
            "<leader>a",
            command = function()
                harpoon:list():append()
            end,
            desc = "Add current file"
        }

        -- nmap {
        --     "<C-e>",
        --     command = function()
        --         harpoon.ui:toggle_quick_menu(harpoon:list())
        --     end,
        --     desc = "Toggle quick menu"
        -- }

        for i, key in ipairs({ 'h', 't', 'n', 's' }) do
            nmap {
                "<C-" .. key .. ">",
                command = function()
                    harpoon:list():select(i)
                end,
                desc = "Select " .. key
            }
        end
    end
}
