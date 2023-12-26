local copilot = require('copilot')
local panel = require('copilot.panel')
local suggestion = require('copilot.suggestion')

copilot.setup({
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
      accept = '<Tab>',
      dismiss = '/',
      next = ']]',
      prev = '[[',
    }
  },
  filetypes = {
    yaml = true,
    markdown = true,
    gitcommit = true,
    svn = true,
  },
})

-- Copilot panel
vim.keymap.set({ 'n', 'i' }, "<C-c>", function()
  panel.open()
  -- Move the the right window
  vim.cmd('wincmd l')
end, { noremap = true, silent = true })
