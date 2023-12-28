vim.g.mapleader = ';'

vim.loader.enable()

require('gillyb/startup')

-- TODO: Remove everything after this


-- Don't use kommentary's default mappings
vim.g.kommentary_create_default_mappings = false
vim.g.nvcode_termcolors = true






-- indentLine
vim.g.indentLine_color_term = 239
--[[ vim.api.nvim_command('autocmd Filetype json :IndentLinesDisable')
vim.api.nvim_command('autocmd BufNewFile json :IndentLinesDisable')
vim.api.nvim_command('autocmd BufEnter json :IndentLinesDisable') ]]



-- Quickfix lists
vim.cmd([[
function! SetQuickFixMappings()
  " Use 'o' to open the file the cursor is on
  nnoremap <buffer> <silent> o <CR>
  " Use 'q' to close the quickfix window
  nnoremap <buffer> <silent> q :q<CR>
  " Set quickfix height to 15
  resize 15
endfunction
autocmd BufReadPost quickfix silent call SetQuickFixMappings()
]])

-- Don't show cursor line in inactive windows
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, { pattern = '*', command = 'set cursorline' })
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, { pattern = '*', command = 'set nocursorline' })

-- Always open quickfix window in full width
vim.api.nvim_create_autocmd({ 'FileType' },
  { pattern = 'qf', command = [[ if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif ]] })
