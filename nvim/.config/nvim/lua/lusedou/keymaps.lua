local M = {}

---@class KeymapSettingOption
---@field noremap? boolean
---@field silent? boolean

---@class KeymapOptions
---@field [1] string
---@field command string | function
---@field options? KeymapSettingOption
---@field desc? string

---@class KeymapGlobOptions
---@field [1] table
---@field [2] string
---@field command string | function
---@field options? KeymapSettingOption
---@field desc? string

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

---Create a keymap for normal mode
---
---@param opts KeymapOptions
---
---Example:
---```lua
---require ('lusedou.keymaps').imap
---
---imap {
---    '<C-j>',
---    command = '<Esc>',
---    options = { noremap = true, silent = true },
---    desc = 'Exit insert mode'
---}
---```
M.imap = function(opts)
    set_keymap('i', opts[1], opts.command, opts.options, opts.desc)
end

---Create a keymap for normal mode
---@param opts KeymapOptions
---
---Example:
---```lua
---require 'lusedou.keymaps'.nmap
---
---nmap {
---    '<leader>q',
---    command = ':q<CR>',
---    options = { noremap = true, silent = true},
---    desc = 'Quit'
---}
---```
M.nmap = function(opts)
    set_keymap('n', opts[1], opts.command, opts.options, opts.desc)
end

---Create a keymap for the given modes
---@param opts KeymapGlobOptions
---
---Example:
---```lua
---require ('lusedou.keymaps').map
---
---```
M.map = function(opts)
    set_keymap(opts[1], opts[2], opts.command, opts.options, opts.desc)
end

return M
