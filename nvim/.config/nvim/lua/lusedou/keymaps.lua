local M = {}

---set_keymap
---@param mode string | table
---@param keymap string
---@param command string | function
---@param options table|nil
---@param desc string|nil
local function set_keymap(mode, keymap, command, options, desc)
    options = options or {}
    options.desc = desc or ""
    vim.keymap.set(mode, keymap, command, options)
end

--- Create a keymap for normal mode
---
--- @param tbl table
--- tbl[1] = keymap
--- tbl.command = string | function
--- tbl.options = table|nil
--- tbl.desc = string|nil
---
--- Example:
--- ```lua
--- require ('lusedou.keymaps').imap
---
--- imap {
---     '<C-j>',
---     command = '<Esc>',
---     options = { noremap = true, silent = true },
---     desc = 'Exit insert mode'
--- }
--- ```
M.imap = function(tbl)
    set_keymap('i', tbl[1], tbl.command, tbl.options, tbl.desc)
end

--- Create a keymap for normal mode
---
--- @param tbl table
--- tbl[1] = keymap
--- tbl.command = string | function
--- tbl.options = table|nil
--- tbl.desc = string|nil
---
--- Example:
--- ```lua
--- require ('lusedou.keymaps').nmap
---
--- nmap {
---     '<leader>q',
---     command = ':q<CR>',
---     options = { noremap = true, silent = true},
---     desc = 'Quit'
--- }
--- ```
M.nmap = function(tbl)
    set_keymap('n', tbl[1], tbl.command, tbl.options, tbl.desc)
end

--- Create a keymap for normal mode
---
--- @param tbl table
--- tbl[1] : string | table = keymap
--- tbl[2] = keymap
--- tbl.command = string | function
--- tbl.options = table|nil
--- tbl.desc = string|nil
---
--- Example:
--- ```lua
--- require ('lusedou.keymaps').map
---
--- map {
---     { 'n', 'i' },
---     '<C-j>',
---     command = '<Esc>',
---     options = { noremap = true, silent = true },
---     desc = 'Exit insert mode'
--- }
--- ```
M.map = function(tbl)
    set_keymap(tbl[1], tbl[2], tbl.command, tbl.options, tbl.desc)
end

return M
