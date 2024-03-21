local api = vim.api

local A = {}

---@class AutocommandOptions
---@field event string | table
---@field group string
---@field pattern string
---@field callback function

local augroup = api.nvim_create_augroup

---Create a new autocommand group
---@param name string
---@return integer
---@usage
---```lua
---local autocommands = require 'lusedou.autocommands'
---
---local augroup = autocommands.augroup('Lusedou_Fugitive')
---
---vim.api.nvim_create_autocmd(
---    'BufWinEnter',
---    {
---       group = augroup,
---       pattern = "fugitive://*",
---       callback = function()
---       if vim.bo.ft ~= "fugitive" then
---       return
---       end
---       -- Do something
---       end,
---    })
A.augroup = function(name)
    return augroup(name, {})
end

---Create a new autocommand
---@param opts AutocommandOptions
---@usage
---```lua
---local autocommands = require 'lusedou.autocommands'
---
---autocommands.autocmd {
---    event = 'BufWinEnter',
---    group = augroup,
---    pattern = "fugitive://*",
---    callback = function()
---        if vim.bo.ft ~= "fugitive" then
---             return
---        end
---        -- Do something
---    end,
---}
---```
A.autocmd = function(opts)
    api.nvim_create_autocmd(opts.event, {
        group = augroup(opts.group, {}),
        pattern = opts.pattern,
        callback = opts.callback,
    })
end

return A
