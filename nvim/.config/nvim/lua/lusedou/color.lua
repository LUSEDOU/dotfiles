local M = {}

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

M.project_theme = nil

M.load_theme = function(name)
    local theme = M.project_theme or name
    if theme and can_load(name) then
        set_color(name)
    end
end

M.set_project_theme = function(name)
    M.project_theme = name
    M.load_theme(name)
end

return M
