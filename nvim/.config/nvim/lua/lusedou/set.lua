

-- set encoding=utf-8  " The encoding displayed.
vim.opt.encoding = "utf-8"
-- set fileencoding=utf-8  " The encoding written to file.
vim.opt.fileencoding = "utf-8"

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.o.exrc = true

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.o.sidescroll = 1
vim.o.sidescrolloff = 5

vim.g.mapleader = " "

-- Ntrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- Hide .g and .freezed files
vim.g.netrw_list_hide = [[\v(\.g|\.freezed)\.dart$]]
vim.g.netrw_hide = 1
vim.g.netrw_localrmdir = "rm -r"
