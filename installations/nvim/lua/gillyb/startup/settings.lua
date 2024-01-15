vim.g.mapleader = ';'

vim.o.compatible = false

vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.bg = 'dark'

vim.o.encoding = 'utf-8'
vim.o.clipboard = 'unnamed'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.laststatus = 3

vim.o.winbar = '%f'
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.autoread = true

vim.o.scrolloff = 3
vim.o.sidescrolloff = 5

vim.o.showcmd = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.wrap = false

vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.o.number = true
vim.o.signcolumn = 'yes'

vim.o.cmdheight = 2
vim.o.pumheight = 11

vim.o.updatetime = 300
vim.o.completeopt = 'menu,menuone,noselect'
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
vim.o.backup = false
vim.o.swapfile = false
vim.o.hidden = true

-- Prevent netrw from loading
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
