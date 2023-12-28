-- Configure .g4 files as antlr syntax
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.g4', command = 'set filetype=antlr4' })
