local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

vim.keymap.set('i', '<C-l>', function() ls.expand() end, { silent = true, desc = 'Expand snippet' })
vim.keymap.set({ 'i', 's' }, '<C-k>', function() ls.jump(1) end, { silent = true, desc = 'Jump' })
vim.keymap.set({ 'i', 's' }, '<C-j>', function() ls.jump(-1) end, { silent = true, desc = 'Jump' })

vim.keymap.set({ 'i', 's' }, '<C-e>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    else
        ls.exit_current()
    end
end, { silent = true, desc = 'Jump' })

-- all
ls.add_snippets('all', {
    s('test', {
        t('test'),
        i(1),
    }),
})

