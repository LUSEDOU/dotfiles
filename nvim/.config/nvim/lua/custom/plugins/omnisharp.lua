return {
  "Hoffs/omnisharp-extended-lsp.nvim",
  ft = "cs",
  config = function()
    local nmap = require 'lusedou.keymaps'.nmap

    -- replaces vim.lsp.buf.definition()
    -- nnoremap gd <cmd>lua require('omnisharp_extended').lsp_definition()<cr>
    --
    -- -- replaces vim.lsp.buf.type_definition()
    -- nnoremap <leader>D <cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>
    --
    -- -- replaces vim.lsp.buf.references()
    -- nnoremap gr <cmd>lua require('omnisharp_extended').lsp_references()<cr>
    --
    -- -- replaces vim.lsp.buf.implementation()
    -- nnoremap gi <cmd>lua require('omnisharp_extended').lsp_implementation()<cr>

    nmap {
      "<leader>gd",
      command = "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>",
      desc = "[G]o to [D]efinition",
    }

    nmap {
      "<leader>D",
      command = "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>",
      desc = "[G]o to type [D]efinition",
    }

    nmap {
      "<leader>gr",
      command = "<cmd>lua require('omnisharp_extended').lsp_references()<cr>",
      desc = "[G]o to [R]eferences",
    }

    nmap {
      "<leader>gi",
      command = "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>",
      desc = "[G]o to [I]mplementation",
    }
  end,
}
