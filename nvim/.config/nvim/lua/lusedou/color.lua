local M = {}

M.project_theme = nil

local function set_color(name)
    -- require 'transparent'.toggle(true)
    vim.cmd.colorscheme(name)
    -- require 'transparent'.toggle(true)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- Border background
    -- vim.api.nvim_set_hl(0, "NormalFloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    -- require 'transparent'.toggle(true)
end

local function can_load(name)
    return vim.g.colors_name ~= name
end

M.load_theme = function(name)
    if M.project_theme == nil and can_load(name) then
        set_color(name)
    end
end

return M
