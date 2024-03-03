-- local lsp = require('lsp-zero').preset({})
-- local cmp = require('cmp')
--
-- lsp.on_attach(function(client, bufnr)
--     -- see :help lsp-zero-keybindings
--     -- to learn the available actions
--
--     local opts = { buffer = bufnr, remap = false }
--
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--     vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--     vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--
--     lsp.default_keymaps({ buffer = bufnr })
-- end)
--
-- -- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--
--
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.complete(),
-- })
--
-- local cmp_sources = {
--     { name = 'nvim_cmp' },
--     { name = 'nvim_lsp' },
--     { name = 'luasnip', option = { show_autosnippets = false } },
--     { name = 'copilot' }
-- }
--
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil
--
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings,
--     sources = cmp_sources
-- })
--
-- lsp.setup()

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),
                sources = {
                    { name = 'nvim_cmp' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip', option = { show_autosnippets = false } },
                    { name = 'copilot' }
                }
            })
        end
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            '<leader>vca', '<leader>vd', '<leader>vws', '<leader>vrr', '<leader>vrn', '<leader>hh',
        },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local nmap = require('lusedou.keymaps').nmap
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                local opts = { buffer = bufnr, remap = false }
                nmap {
                    '<leader>vca',
                    command = function() vim.lsp.buf.code_action() end,
                    desc = 'view code actions',
                    opts = opts,
                }

                nmap {
                    '<leader>vd',
                    command = function() vim.diagnostic.open_float() end,
                    desc = 'view diagnostic',
                    opts = opts,
                }

                nmap {
                    '<leader>vws',
                    command = function() vim.lsp.buf.workspace_symbol() end,
                    desc = 'view workspace symbol',
                    opts = opts,
                }

                nmap {
                    '<leader>vrr',
                    command = function() vim.lsp.buf.references() end,
                    desc = 'view references',
                    opts = opts,
                }

                nmap {
                    '<leader>vrn',
                    command = function() vim.lsp.buf.rename() end,
                    desc = 'rename',
                    opts = opts,
                }

                nmap {
                    '<leader>hh',
                    command = function() vim.lsp.buf.signature_help() end,
                    desc = 'Go help',
                    opts = opts,
                }

                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },
    {
        'deathbeam/lspecho.nvim',
        opts = {
            echo = true,  -- Echo progress messages, if set to false you can use .message() to get the current message
            decay = 3000, -- Message decay time in milliseconds
        },
        event = 'BufReadPre',
        config = true,
    },

}
