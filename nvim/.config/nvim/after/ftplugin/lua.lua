-- source the current file
local Lusedou_Ftplugin_Lua = vim.api.nvim_create_augroup("Lusedou_Ftplugin_Lua", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWinEnter", {
  group = Lusedou_Ftplugin_Lua,
  pattern = "*.lua",
  callback = function()
    if vim.bo.ft ~= "lua" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()

    vim.keymap.set("n", "<leader>ll", function()
      vim.cmd("source %")
      print("Sourced " .. vim.fn.expand("%"))
    end, { silent = true, desc = "Source the current file", buffer = bufnr, remap = false })
  end,
})
