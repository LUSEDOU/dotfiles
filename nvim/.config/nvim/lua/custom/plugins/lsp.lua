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
            -- local cmp_action = lsp_zero.cmp_action()
            local behavior = { behavior = cmp.SelectBehavior.select }

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-p>'] = cmp.mapping.select_prev_item(behavior),
                    ['<C-n>'] = cmp.mapping.select_next_item(behavior),
                    ['<Tab>'] = nil,
                    ['<S-Tab>'] = nil,

                    -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
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
            '<leader>vca', '<leader>vd', '<leader>vws', '<leader>vrr', '<leader>vrn', '<leader>hh', '<leader>gd', 'K',
            '<C-h>',
        },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local nmap = require('lusedou.keymaps').nmap
            local imap = require('lusedou.keymaps').imap
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
                    command = vim.lsp.buf.code_action,
                    desc = 'view code actions',
                    opts = opts,
                }

                nmap {
                    'gd',
                    command = function()
                        vim.lsp.buf.definition()
                        vim.cmd('normal! zz')
                    end,
                    desc = 'view definition',
                    opts = opts,
                }

                nmap {
                    'K',
                    command = vim.lsp.buf.hover,
                    desc = 'view definition',
                    opts = opts,
                }

                nmap {
                    '<leader>vd',
                    command = vim.diagnostic.open_float,
                    desc = 'view diagnostic',
                    opts = opts,
                }

                nmap {
                    '<leader>vws',
                    command = vim.lsp.buf.workspace_symbol,
                    desc = 'view workspace symbol',
                    opts = opts,
                }

                nmap {
                    '<leader>vrr',
                    command = vim.lsp.buf.references,
                    desc = 'view references',
                    opts = opts,
                }

                nmap {
                    '<leader>vrn',
                    command = vim.lsp.buf.rename,
                    desc = 'rename',
                    opts = opts,
                }

                imap {
                    '<C-h>',
                    command = vim.lsp.buf.signature_help,
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
