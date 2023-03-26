vim.g.mapleader = ';'

vim.o.compatible = false
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.bg = 'dark'
vim.o.encoding = 'utf-8'
vim.o.clipboard = 'unnamed'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.laststatus = 3
vim.o.winbar = '%f'
vim.o.autoindent = true
vim.o.expandtab = true
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
vim.o.cmdheight = 2
vim.o.pumheight = 11
vim.o.updatetime = 300
vim.o.completeopt = 'menu,menuone,noselect'
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
vim.o.backup = false
vim.o.swapfile = false
vim.o.hidden = true
vim.cmd('syntax on')

-- Don't use kommentary's default mappings
vim.g.kommentary_create_default_mappings = false

vim.g.nvcode_termcolors = true

vim.o.background = 'dark'



-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('plugins')
require('keys')

-- indentLine
vim.g.indentLine_color_term = 239
-- vim.api.nvim_command('autocmd Filetype json :IndentLinesDisable')
-- vim.api.nvim_command('autocmd BufNewFile json :IndentLinesDisable')
-- vim.api.nvim_command('autocmd BufEnter json :IndentLinesDisable')

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeStatusLine = ''
vim.g.NERDTreeWinSize = 40
vim.cmd("let g:NERDTreeIgnore = ['^\\.DS_Store', '\\.git$[[dir]]', '\\.idea$[[dir]]']")

-- Open NERDTree immediately when opening vim
vim.cmd([[
function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction
autocmd VimEnter * call StartUp()
]])

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
vim.api.nvim_create_autocmd({'InsertLeave', 'WinEnter'}, {pattern='*', command='set cursorline'})
vim.api.nvim_create_autocmd({'InsertEnter', 'WinLeave'}, {pattern='*', command='set nocursorline'})

-- Always open quickfix window in full width
vim.api.nvim_create_autocmd({'FileType'}, {pattern='qf', command=[[ if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif ]]})
