return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
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

        nmap {
            "<C-e>",
            command = function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Toggle quick menu"
        }

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
