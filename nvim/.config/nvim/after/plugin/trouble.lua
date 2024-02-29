local trouble = require('trouble')

vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, { desc = 'Show troubles' })
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end, { desc = 'Show Workspace' })
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end, { desc = 'Show Document' })
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end, { desc = 'Show Quickfix' })
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end, { desc = 'Show LocList' })
vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end, { desc = 'Show Lsp References' })
