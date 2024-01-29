vim.g.mapleader = ';'

vim.loader.enable()

require('gillyb/startup')

-- Don't show cursor line in inactive windows
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, { pattern = '*', command = 'set cursorline' })
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, { pattern = '*', command = 'set nocursorline' })
