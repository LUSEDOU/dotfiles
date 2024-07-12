require "custom.snippets"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
lspkind.init {}

local cmp = require "cmp"


local behavior = { behavior = cmp.SelectBehavior.select }

local mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-p>'] = cmp.mapping.select_prev_item(behavior),
    ['<C-n>'] = cmp.mapping.select_next_item(behavior),
}

mapping['<Tab>'] = nil
mapping['<S-Tab>'] = nil

local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}


cmp.setup {
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'luasnip', option = { show_autosnippets = false } },
        { name = 'nvim_cmp' },
        -- { name = "cody" },
        { name = "path" },
        { name = "buffer" },
        { name = 'copilot' }
    },
    window = {
        completion = {
            border = "rounded",
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat",
        },
        documentation = {
            border = "rounded",
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat",
        },
    },
    mapping = mapping,
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
}

vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
