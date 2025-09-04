return {
    'tjdevries/ocaml.nvim',
    config = true,
    ft = { "ml", "mli" },
    build = function ()
        require('ocaml').update()
    end
}
