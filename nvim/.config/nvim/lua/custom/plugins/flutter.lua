return {
    'akinsho/flutter-tools.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    ft = 'dart',
    opts = {
        fvm = true,
        settings = {
            analysis = {
                vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
            }
        },
        -- lsp = {
        --     on_attach = function(client, bufnr)
        --         print('Flutter tools attached')
        --         local nmap = require('lusedou.keymaps').nmap
        --
        --         opts = { buffer = bufnr, remap = false }
        --
        --         nmap {
        --             '<leader>gd',
        --             command = vim.lsp.buf.definition,
        --             desc = 'view definition',
        --             opts = opts,
        --         }
        --     end
        -- }
    },
    config = true,
}
