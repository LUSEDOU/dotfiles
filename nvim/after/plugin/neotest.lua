local neotest = require('neotest')
local opts = { noremap = true, silent = true }

neotest.setup({
    adapters = {
        require('neotest-dart') {
            command = 'fvm flutter',
            use_fvm = true,
        },
    }
})

vim.keymap.set("n", "<leader>tt", function() neotest.run.run() end, opts, "[T]est [t]est")
vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, opts, "[T]est [f]ile")
vim.keymap.set("n", "<leader>ts", function() neotest.run.stop() end, opts, "[T]est [s]top")
