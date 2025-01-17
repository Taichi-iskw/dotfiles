vim.opt.fileencoding = "utf-8"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- lazy.nvim
require("config.lazy")

vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>")
