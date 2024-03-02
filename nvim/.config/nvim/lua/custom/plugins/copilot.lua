return {
    'zbirenbaum/copilot.lua',
    build = ":Copilot auth",
    keys = function()
        local copilot = require('copilot')
        local suggestion = require('copilot.suggestion')
        local panel = require('copilot.panel')

        local function remap(key, command)
            if (suggestion.is_visible()) then
                command()
            else
                local keyy = vim.api.nvim_replace_termcodes(key, true, false, true)
                vim.api.nvim_feedkeys(keyy, "n", false)
            end
        end

        return {
            {
                '<C-c>',
                function()
                    panel.open({
                        position = 'right',
                        size = 0.5,
                    })

                    vim.cmd('wincmd l')
                end,
                desc = "Open Copilot panel"
            },
            { '<Tab>', function() remap('<Tab>', suggestion.accept) end },
            { '/',     function() remap('/', suggestion.dismiss) end },
            { ']]',    function() remap(']]', suggestion.next) end },
            { '[[',    function() remap('[[', suggestion.prev) end },

        }
    end,
    lazy = false,
    opts = {
        panel = {
            auto_refresh = true,
            layout = {
                position = 'right',
            }
        },
        suggestion = {
            debounce = 50,
            auto_trigger = true,
            keymap = {
                accept = nil,
                dismiss = nil,
                next = nil,
                prev = nil,
            }
        },
        filetypes = {
            yaml = true,
            markdown = true,
            gitcommit = true,
            svn = true,
        },
    },
    config = true
}
