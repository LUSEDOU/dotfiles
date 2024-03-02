return {
  'ibhagwan/fzf-lua',
  opts = {},
  config = function()
    local fzf = require('fzf-lua')
    local nmap = require('lusedou.keymaps').nmap

    nmap {
      '<leader>pf',
      command = fzf.files,
      desc = 'Files'
    }

    nmap {
      '<C-P>',
      command = fzf.git_files,
      desc = 'Git Files'
    }

    nmap {
      '<leader>ps',
      command = function()
        local word = vim.fn.input("Grep > ")
        if word ~= "" then
          fzf.grep({ search = word })
        end
      end,
      desc = 'Live Grep'
    }

    nmap {
      '<leader>pws',
      command = function()
        local word = vim.fn.expand("<cword>")
        fzf.grep({ search = word })
      end,
      desc = 'Grep Word'
    }

    nmap {
      '<leader>pWs',
      command = function()
        local word = vim.fn.expand("<cWORD>")
        fzf.grep({ search = word })
      end,
      desc = 'Grep WORD'
    }

    nmap {
      '<leader>pp',
      command = fzf.builtin,
      desc = 'Builtin'
    }

  end
}
