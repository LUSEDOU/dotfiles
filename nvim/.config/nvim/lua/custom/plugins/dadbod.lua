return {
  'kristijanhusak/vim-dadbod-ui',
  enabled = false,
  dependencies = {
    {
      "tpope/vim-dadbod",
      lazy = true,
      cmd = { 'DB', 'DBUI' },
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
    },
  },
  cmd = { 'DBUIToggle', 'DBUI', 'DBUIFindBuffer', 'DBUIRenameBuffer' },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end
}
