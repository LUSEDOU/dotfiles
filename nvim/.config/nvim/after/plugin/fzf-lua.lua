local fzf = require('fzf-lua')

fzf.setup({})

-- local function
local function set_keymap(keymap, command, options)
  vim.keymap.set('n', keymap, command, options)
end

set_keymap('<leader>pf', fzf.files)
set_keymap('<C-P>', fzf.git_files)
set_keymap('<leader>ps', function()
  fzf.grep({search = vim.fn.input("Grep > ") })
end)
set_keymap('<leader>pp', fzf.builtin)
