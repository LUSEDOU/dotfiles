return {
  'kristijanhusak/vim-dadbod-ui',
  enabled = false,
  dependencies = {
    {
      "tpope/vim-dadbod",
      lazy = true,
      enabled = false,
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
      enabled = false,
    },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end
}
