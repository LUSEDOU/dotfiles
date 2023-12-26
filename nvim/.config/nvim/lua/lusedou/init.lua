require("lusedou.remap")
require("lusedou.lazy")
require("lusedou.set")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = augroup(
    'HighlightYank',
    { clear = true }
)

autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
    group = highlight_group,
    pattern = '*',
})

local lusedouGroup  = augroup('Lusedou', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd({ "BufWritePre" }, {
    group = lusedouGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

