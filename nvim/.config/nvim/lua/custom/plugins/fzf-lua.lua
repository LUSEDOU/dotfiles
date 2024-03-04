return {
  'ibhagwan/fzf-lua',
  opts = {},
  config = true,
  keys = {
    { '<leader>pf', function() require('fzf-lua').files() end,   desc = 'Files' },
    { '<C-P>',      function() require('fzf-lua').git_files() end, desc = 'Git Files' },
    { '<leader>pp', function() require('fzf-lua').builtin() end, desc = 'Builtin' },
    {
      '<leader>ps',
      function()
        local word = vim.fn.input("Grep > ")
        if word ~= "" then
          require('fzf-lua').grep({ search = word })
        end
      end,
      desc = 'Live Grep'
    },
    {
      '<leader>pws',
      function()
        local word = vim.fn.expand("<cword>")
        require('fzf-lua').grep({ search = word })
      end,
      desc = 'Grep Word'
    },
    {
      '<leader>pWs',
      function()
        local word = vim.fn.expand("<cWORD>")
        require('fzf-lua').grep({ search = word })
      end,
      desc = 'Grep WORD'
    },
  },
}
