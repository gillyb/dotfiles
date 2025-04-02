vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeStatusLine = ''
vim.g.NERDTreeWinSize = 36
vim.cmd("let g:NERDTreeIgnore = ['^\\.DS_Store', '\\.git$[[dir]]', '\\.idea$[[dir]]']")

-- Open NERDTree immediately when opening vim
vim.cmd([[
function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction
autocmd VimEnter * call StartUp()

autocmd VimEnter * NERDTree
]])
