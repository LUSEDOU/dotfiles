return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufWinEnter",
  opts = {},

  -- { '<leader>xx', function() trouble.toggle() end,                        { desc = 'Show troubles' } },
  -- { '<leader>xw', function() trouble.toggle("workspace_diagnostics") end, { desc = 'Show Workspace' } },
  -- { '<leader>xd', function() trouble.toggle("document_diagnostics") end,  { desc = 'Show Document' } },
  -- { '<leader>xq', function() trouble.toggle("quickfix") end,              { desc = 'Show Quickfix' } },
  -- { '<leader>xl', function() trouble.toggle("loclist") end,               { desc = 'Show LocList' } },
  -- { 'gR',         function() trouble.toggle("lsp_references") end,        { desc = 'Show Lsp References' } },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xw",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>gr",
      "<cmd>Trouble lsp_references toggle<cr>",
      desc = "LSP References (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false win.position=left<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=left<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
