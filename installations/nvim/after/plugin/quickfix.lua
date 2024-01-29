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

-- Always open quickfix window in full width
vim.api.nvim_create_autocmd({ 'FileType' },
  { pattern = 'qf', command = [[ if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif ]] })
