return {
  'zbirenbaum/copilot.lua',
  build = ":Copilot auth",
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
  config = function(_, opts)
    local k = require("lusedou.keymaps")
    local suggestion = require('copilot.suggestion')
    local panel = require('copilot.panel')
    local copilot = require('copilot')

    copilot.setup(opts)

    local function remap(key, command)
      k.imap {
        key,
        command = function()
          if (suggestion.is_visible()) then
            command()
          else
            local keyy = vim.api.nvim_replace_termcodes(key, true, false, true)
            vim.api.nvim_feedkeys(keyy, "n", false)
          end
        end,
        opts = { silent = true }
      }
    end

    remap("<Tab>", suggestion.accept)
    remap("/", suggestion.dismiss)
    remap("]]", suggestion.next)
    remap("[[", suggestion.prev)

    k.map {
      { "n", "i" },
      "<C-c>",
      command = function()
        panel.open({
          position = 'right',
          size = 0.5,
        })

        vim.cmd('wincmd l')
      end,
      desc = "Open Copilot panel",
      opts = { noremap = true, silent = true }
    }
  end
}
