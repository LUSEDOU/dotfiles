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
        }
    },
    config = true,
}
