return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        require 'neodev'.setup {}

        local capabilities = nil

        if pcall(require, "cmp_nvim_lsp") then
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        end

        local lspconfig = require 'lspconfig'

        local servers = {
            gopls = {
                settings = {
                    gopls = {
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            },
            lua_ls = {
                server_capabilities = {
                    semanticTokensProvider = vim.NIL,
                },
            },
            ocamllsp = {
                manual_install = true,
                settings = {
                    codelens = { enable = true },
                    inlayHints = { enable = true },
                },

                filetypes = {
                    "ocaml",
                    "ocaml.interface",
                    "ocaml.menhir",
                    "ocaml.cram",
                },
            },
            biome = true,
        }

        local servers_to_install = vim.tbl_filter(function(key)
            local t = servers[key]
            if type(t) == "table" then
                return not t.manual_install
            else
                return t
            end
        end, vim.tbl_keys(servers))

        require 'mason'.setup()
        local ensure_installed = {
            "stylua",
            "lua_ls",
            -- "tailwind-language-server",
        }

        vim.list_extend(ensure_installed, servers_to_install)
        require("mason-tool-installer").setup { ensure_installed = ensure_installed }

        for server, config in pairs(servers) do
            if config == true then
                config = {}
            end
            config = vim.tbl_deep_extend("force", {}, {
                capabilities = capabilities,
            }, config)

            lspconfig[server].setup(config)
        end


        local disable_semantic_tokens = {
            lua = true,
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                local settings = servers[client.name]
                if type(settings) ~= "table" then
                    settings = {}
                end

                local kmap = require 'lusedou.keymaps'
                local nmap = kmap.nmap
                local imap = kmap.imap

                local opts = { buffer = bufnr, remap = false }

                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

                nmap {
                    '<leader>ca',
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
                    'gD',
                    command = vim.lsp.buf.declaration,
                    desc = 'view declaration',
                    opts = opts,
                }

                nmap {
                    'gT',
                    command = vim.lsp.buf.type_definition,
                    desc = 'view type definition',
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
                    '<leader>vr',
                    command = vim.lsp.buf.references,
                    desc = 'view references',
                    opts = opts,
                }

                nmap {
                    '<leader>vn',
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

                local filetype = vim.bo[bufnr].filetype
                if disable_semantic_tokens[filetype] then
                    client.server_capabilities.semanticTokensProvider = nil
                end

                -- Override server capabilities
                if settings.server_capabilities then
                    for k, v in pairs(settings.server_capabilities) do
                        if v == vim.NIL then
                            ---@diagnostic disable-next-line: cast-local-type
                            v = nil
                        end

                        client.server_capabilities[k] = v
                    end
                end
            end,
        })
    end,
}
