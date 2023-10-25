local exclude_folders = {
    vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
}

require("flutter-tools").setup({
    fvm = true,
    settings = {
        analysis = exclude_folders,
    }
})
