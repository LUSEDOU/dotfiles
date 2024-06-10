return {
    'akinsho/flutter-tools.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "j-hui/fidget.nvim",
    },
    ft = 'dart',
    opts = {
        fvm = false,
        -- flutter_path = '/opt/flutter/bin/flutter',
        -- settings = {
        --     analysis = {
        --         vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        --     }
        -- },
        lsp = {
            on_attach = function(client, bufnr)
                print('Flutter tools attached')
                local nmap = require('lusedou.keymaps').nmap
                local flutter = require('flutter-tools.commands')

                local opts = { buffer = bufnr, remap = false }
            end
        }
    },
    config = true,
}
