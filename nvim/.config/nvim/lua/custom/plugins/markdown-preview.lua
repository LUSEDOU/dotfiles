return {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && yarn install',
  -- dependencies = {
  --     'preservim/vim-markdown',
  -- }
  ft = { 'markdown' },
  keys = {
    { '<leader>mpp', '<cmd>MarkdownPreview<cr>',       desc = 'Markdown Preview' },
    { '<leader>mpt', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview Toggle' },
    { '<leader>mps', '<cmd>MarkdownPreviewStop<cr>',   desc = 'Markdown Preview Stop' },
  },
  init = function()
    vim.g.mkdp_browser = 'surf'
  end,
}
