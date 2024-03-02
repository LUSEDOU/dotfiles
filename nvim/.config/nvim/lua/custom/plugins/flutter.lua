return {
    'akinsho/flutter-tools.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
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
