return {
    'tjdevries/ocaml.nvim',
    config = true,
    build = function ()
        require('ocaml').update()
    end
}
