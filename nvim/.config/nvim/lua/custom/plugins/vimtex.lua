return {
  'lervag/vimtex',
  ft = 'tex',
  init = function()
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_mode = 0

    vim.o.conceallevel = 1
    vim.g.text_conceal = 'abdmg'
    vim.g.vimtex_format_enabled = 3
  end,
  config = function()
    local nmap = require 'lusedou.keymaps'.nmap

    local autocmd = require 'lusedou.autocommands'.autocmd

    autocmd {
      group = 'Lusedou_Vimtex',
      event = 'BufWinEnter',
      pattern = '*.tex',
      callback = function()
        -- nmap {
        --   'gd',
          -- command = tex.
        -- }
      end
    }
  end
}
