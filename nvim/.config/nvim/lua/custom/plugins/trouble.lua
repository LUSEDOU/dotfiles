return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = function()
    local trouble = require('trouble')

    return {
      { '<leader>xx', function() trouble.toggle() end,                        { desc = 'Show troubles' } },
      { '<leader>xw', function() trouble.toggle("workspace_diagnostics") end, { desc = 'Show Workspace' } },
      { '<leader>xd', function() trouble.toggle("document_diagnostics") end,  { desc = 'Show Document' } },
      { '<leader>xq', function() trouble.toggle("quickfix") end,              { desc = 'Show Quickfix' } },
      { '<leader>xl', function() trouble.toggle("loclist") end,               { desc = 'Show LocList' } },
      { 'gR',         function() trouble.toggle("lsp_references") end,        { desc = 'Show Lsp References' } },
    }
  end,
  opts = {},
}
