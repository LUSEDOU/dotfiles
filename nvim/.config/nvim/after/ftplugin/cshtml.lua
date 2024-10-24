-- change ft to html
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.cshtml",
  callback = function()
    vim.bo.textwidth = 80
  end,
})
